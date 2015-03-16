class Contracto::Command::Start::Base
  PORT = 54321

  def initialize(args)
    @args = args
  end

  def execute
    raise NotImplementedError
  end

  private

  def start_server
    raise Contracto::ServerAlreadyRunningError if server_already_running?

    system "rackup #{Contracto::CONTRACTO_DIR}/config.ru -p #{PORT} -D -P #{Contracto::CONTRACT_PID_FILEPATH}"
    # TODO: loop below should terminate after n tries
    system "while ! echo exit | nc localhost #{PORT} > /dev/null && echo \"waiting for contracto server...\"; do sleep 1; done"
    test_request
  end

  def server_already_running?
    test_request(silent: true)
  end

  def test_request(options = {})
    args = ''
    args << '-s -o /dev/null' if options[:silent]
    system "curl #{args} 0.0.0.0:#{PORT}/contracto"
  end

  def server_repo_url
    @args.first
  end
end