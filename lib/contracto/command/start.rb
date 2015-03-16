class Contracto::Command::Start
  require_relative 'start/base'
  require_relative 'start/remote'
  require_relative 'start/local'

  def initialize(args)
    if args.first
      @strategy = Contracto::Command::Start::Remote.new(args)
    else
      @strategy = Contracto::Command::Start::Local.new(args)
    end
  end

  def execute
    @strategy.execute
  end
end
