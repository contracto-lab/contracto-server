class Contracto::Command::Start::Local < Contracto::Command::Start::Base
  def execute
    Contracto::SystemActionChain.new(*actions).execute
  end

  private

  def actions
    [:start_server]
  end
end