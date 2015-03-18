class Contracto::SystemAction
  class << self
    include Contracto::Constants

    def remove_contracto_dir
      FileUtils.rm_rf contracto_dir
    end

    def remove_tmp_contracto_dir
      FileUtils.rm_rf contracto_tmp_dir
    end

    def copy_server_files
      FileUtils.cp_r ruby_server_dir, contracto_tmp_dir
      FileUtils.mv contracto_tmp_dir, contracto_dir
    end

    def revert_copy_server_files
      remove_contracto_dir
      remove_tmp_contracto_dir
    end

    def create_sample_contract
      if contract_already_exists?
        puts 'contract already exists, creating sample contract skipped'
        remove_sample_contract
      else
        FileUtils.mv sample_contract_path, FileUtils.pwd
        puts "created: #{contract_filename}"
      end
    end

    def start_server
      raise Contracto::ServerAlreadyRunningError if server_already_running?

      system "rackup #{contracto_dir}/config.ru -p #{port} -D -P #{contract_pid_filepath}"
      # TODO: loop below should terminate after n tries
      system "while ! echo exit | nc localhost #{port} > /dev/null && echo \"waiting for contracto server...\"; do sleep 1; done"
      test_request
    end

    def stop_server
      puts 'killing server...'
      Process.kill(15, File.read(contract_pid_filepath).to_i)
      puts '...server killed'
    end

    def revert_start_server
      stop_server
    end

    def clone_repo_to_tmp_contracto_dir
      system "git clone -q  --depth 1 --single-branch --branch master #{Contracto::Config.repo_url} #{contracto_tmp_dir}"
    rescue
      raise(Contracto::CouldNotDownloadContractError.new(Contracto::Config.repo_url))
    end

    def revert_clone_repo_to_tmp_contracto_dir
      remove_tmp_contracto_dir
    end

    def move_repo_files_to_root_dir
      system "mv #{contracto_tmp_dir}/* #{contracto_tmp_dir}/.[^.]* . 2> /dev/null"  # Could not use FileUtils for some reason
    end
    
    private

    def contract_already_exists?
      File.exist?(contract_filename)
    end

    def remove_sample_contract
      FileUtils.rm sample_contract_path
    end

    def sample_contract_path
      "#{contracto_dir}/#{contract_filename}"
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
  end

  def execute
    perform_actions and true
  rescue StandardError => e
    puts "ERROR: #{e.class}: #{e.message}"
    puts "#{e.backtrace.join("\n")}"

    revert_actions and false
  end

  private

  def perform_actions
    @actions.each do |action|
      Contracto::SystemAction.send(action)
    end
  end

  def revert_actions
    @actions.each do |action|
      revert_method_name = "revert_#{action}"
      if Contracto::SystemAction.respond_to? revert_method_name
        Contracto::SystemAction.send revert_method_name
      end
    end
  rescue StandardError
  end
end
