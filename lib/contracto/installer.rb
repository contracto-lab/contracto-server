class Contracto::Installer
  require 'contracto/installer/local'

  def initialize(args)
    if args.empty?
      @strategy = Contracto::Installer::Local.new
    end
  end

  def execute
    @strategy.execute
  end
end