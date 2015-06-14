class Contracto::Command::Init
  def initialize(args)
  end

  def execute
    initialized = Contracto::SystemActionChain.new(*actions).execute

    if initialized
      puts 'contract initialized, enter "contracto start" to start server'
    else
      puts 'initializing contract failed'
    end
  end

  private

  def actions
    [:create_sample_contract]
  end
end
