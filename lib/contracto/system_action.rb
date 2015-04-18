require 'fileutils'

class Contracto::SystemAction
  require_relative 'server'

  extend Contracto::Constants

  class << self

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
      Contracto::Server.start_contracto_server!
    end

    def stop_server
      Contracto::Server.stop_contracto_server!
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
