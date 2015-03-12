class Contracto::Runner
  PORT = 54321

  def initialize(args)
  end

  def execute
    system "rackup contracto/config.ru -p #{PORT} &"
    system "while ! echo exit | nc localhost #{PORT} > /dev/null && echo \"Waiting for server...\"; do sleep 1; done"
  end
end