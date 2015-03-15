class Contracto::Runner::Base
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
    system "curl 0.0.0.0:#{PORT}"
  end

  def server_already_running?
    system "curl -s -o /dev/null 0.0.0.0:#{PORT} 2> /dev/null"
  end

  def server_repo_url
    @args.first
  end
end