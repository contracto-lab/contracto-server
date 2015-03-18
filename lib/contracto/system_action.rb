class Contracto::SystemAction
  class << self
    def remove_contracto_dir
      FileUtils.rm_rf Contracto::CONTRACTO_DIR
    end

    def remove_tmp_contracto_dir
      FileUtils.rm_rf Contracto::CONTRACTO_TMP_DIR
    end

    def copy_server_files
      FileUtils.cp_r Contracto::RUBY_SERVER_DIR, Contracto::CONTRACTO_TMP_DIR
      FileUtils.mv Contracto::CONTRACTO_TMP_DIR, Contracto::CONTRACTO_DIR
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
        puts "created: #{Contracto::CONTRACT_FILENAME}"
      end
    end

    def start_server
      raise Contracto::ServerAlreadyRunningError if server_already_running?

      system "rackup #{Contracto::CONTRACTO_DIR}/config.ru -p #{Contracto::PORT} -D -P #{Contracto::CONTRACT_PID_FILEPATH}"
      # TODO: loop below should terminate after n tries
      system "while ! echo exit | nc localhost #{Contracto::PORT} > /dev/null && echo \"waiting for contracto server...\"; do sleep 1; done"
      test_request
    end

    def revert_start_server
      stop_server
    end
    
    private

    def contract_already_exists?
      File.exist?(Contracto::CONTRACT_FILENAME)
    end

    def remove_sample_contract
      FileUtils.rm sample_contract_path
    end

    def sample_contract_path
      "#{Contracto::CONTRACTO_DIR}/#{Contracto::CONTRACT_FILENAME}"
    end

    def server_already_running?
      test_request(silent: true)
    end

    def test_request(options = {})
      args = ''
      args << '-s -o /dev/null' if options[:silent]
      system "curl #{args} 0.0.0.0:#{Contracto::PORT}/contracto"
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
    puts "ERROR: #{e.class}"
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
