class Contracto::Runner
  require_relative 'runner/base'
  require_relative 'runner/remote'
  require_relative 'runner/local'

  def initialize(args)
    if args.first
      @strategy = Contracto::Runner::Remote.new(args)
    else
      @strategy = Contracto::Runner::Local.new(args)
    end
  end

  def execute
    @strategy.execute
  end
end
