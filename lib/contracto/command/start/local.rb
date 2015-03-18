class Contracto::Command::Start::Local
  def execute
    Contracto::SystemActionChain.new(*actions).execute
  end

  private

  def actions
    [:start_server]
  end
end