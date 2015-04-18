class Contracto::Command::Start
  require_relative 'start/remote'
  require_relative 'start/local'

  def initialize(args)
    puts 'starting contracto server...'
    if args.first
      @strategy = Contracto::Command::Start::Remote.new(args.first)
    else
      @strategy = Contracto::Command::Start::Local.new
    end
  end

  def execute
    @strategy.execute
  end
end
