class Contracto::Terminator
  def initialize(args)
  end

  def execute
    Process.kill(15, File.read(Contracto::CONTRACT_PID_FILEPATH).to_i)
  end
end