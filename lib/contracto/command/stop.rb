class Contracto::Command::Stop
  def initialize(args)
  end

  def execute
    puts 'killing server...'
    Process.kill(15, File.read(Contracto::CONTRACT_PID_FILEPATH).to_i)
    puts 'server terminated'
  end
end