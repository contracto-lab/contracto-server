class Contracto::Installer
  require 'contracto/installer/local'

  CONTRACTO_DIR = 'contracto'
  CONTRACTO_TMP_DIR = '.tmp.contracto'
  RUBY_SERVER_DIR = "#{Contracto::GEM_DIR}/lib/contracto/server/ruby"
  CONTRACT_FILENAME = 'contract.cdc.rb'

  def initialize(args)
    if args.empty?
      @strategy = Contracto::Installer::Local.new
    end
  end

  def execute
    @strategy.execute
  end
end