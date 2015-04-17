class Contracto::SystemAction
  require 'fileutils'

  class << self
    include Contracto::Constants

    def create_sample_contract
      if Dir.exists?(Contracto::Config.root_dir)
        puts 'contract already exists, creating sample contract skipped'
      else
        FileUtils.cp_r sample_contract_dir, Contracto::Config.root_dir
      end
    end

    def revert_create_sample_contract
      remove_root_dir
    end

    def start_server
      raise Contracto::ServerAlreadyRunningError if server_already_running?

      require_relative 'server/ruby/server'
      require 'daemons'

      options = {
        app_name: server_pidfile_name,
        dir: Contracto::Config.root_dir,
        dir_mode: :normal
      }

      Daemons.call(options) do
        Contracto::Server.run!
      end

      5.downto(0).each do |n|
        sleep 1
        puts "waiting for contracto server, #{n} tries left..."
        break if test_request(silent: true)
      end
    end

    def stop_server
      puts 'killing server...'
      system "curl 0.0.0.0:#{port}/contracto_terminate"
      puts '...server killed'
    end

    def revert_start_server
      stop_server
    rescue StandardError
    end

    def clone_repo
      FileUtils.rm_rf Contracto::Config.root_dir
      success = system "git clone -q  --depth 1 --single-branch --branch master #{Contracto::Config.repo_url} #{Contracto::Config.root_dir}"
      raise(Contracto::CouldNotDownloadContractError.new(Contracto::Config.repo_url)) unless success
    end

    def revert_clone_repo
      remove_root_dir
    end

    private

    def remove_root_dir
      FileUtils.rm_rf Contracto::Config.root_dir
    end

    def server_already_running?
      test_request(silent: true)
    end

    def test_request(options = {})
      args = ''
      args << '-s -o /dev/null' if options[:silent]
      system "curl #{args} 0.0.0.0:#{port}/contracto"
    end
  end
end

class Contracto::SystemActionChain
  def initialize(*actions)
    @actions = actions
    @finished_actions = []
  end

  def execute
    perform_actions and true
  rescue StandardError => e
    revert_actions and false
    raise e
  end

  private

  def perform_actions
    @actions.each do |action|
      @finished_actions << action
      Contracto::SystemAction.send(action)
    end
  end

  def revert_actions
    @finished_actions.reverse.each do |action|
      revert_method_name = "revert_#{action}"
      if Contracto::SystemAction.respond_to? revert_method_name
        Contracto::SystemAction.send revert_method_name
      end
    end
  rescue StandardError
  end
end
