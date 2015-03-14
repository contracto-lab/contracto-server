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
    system "rackup #{Contracto::CONTRACTO_DIR}/config.ru -p #{PORT} -D -P #{Contracto::CONTRACT_PID_FILEPATH}"
    # TODO: loop below should terminate after n tries
    system "while ! echo exit | nc localhost #{PORT} > /dev/null && echo \"Waiting for server...\"; do sleep 1; done"
    system "curl 0.0.0.0:#{PORT}"
  end

  def server_repo_url
    @args.first
  end
end