class Contracto::Runner
  PORT = 54321

  def initialize(args)
  end

  def execute
    system "rackup #{Contracto::CONTRACTO_DIR}/config.ru -p #{PORT} -D -P #{Contracto::CONTRACTO_DIR}/server.pid"
    system "while ! echo exit | nc localhost #{PORT} > /dev/null && echo \"Waiting for server...\"; do sleep 1; done"
    system "curl 0.0.0.0:#{PORT}"
  end
end