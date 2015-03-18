class Contracto::Command::Stop
  def initialize(args)
  end

  def execute
    Contracto::SystemActionChain.new(*actions).execute
  end

  private

  def actions
    [:stop_server]
  end
end