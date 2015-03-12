class Contracto::Runner
  PORT = 54321

  def initialize(args)

  end

  def execute
    system "rackup contracto/config.ru -p #{PORT}"
  end
end