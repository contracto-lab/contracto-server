class Contracto::Command::Start::Local < Contracto::Command::Start::Base
  def execute
    start_server
  end
end