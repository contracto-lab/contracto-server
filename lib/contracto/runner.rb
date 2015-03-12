class Contracto::Runner
  PORT = 54321

  def initialize(args)
  end

  def execute
    system "ruby contracto/server.rb -p #{PORT} &"
    system "while ! echo exit | nc localhost #{PORT} > /dev/null && echo \"Waiting for server...\"; do sleep 1; done"
    system "curl http://localhost:#{PORT}"
  end
end