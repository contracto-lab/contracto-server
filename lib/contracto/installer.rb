class Contracto::Installer
  require_relative 'installer/local'

  def initialize(args)
    if args.empty?
      @strategy = Contracto::Installer::Local.new
    end
  end

  def execute
    @strategy.execute
  end
end