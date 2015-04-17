class Contracto::Command
  require_relative 'command/init'
  require_relative 'command/start'
  require_relative 'command/stop'
  class << self

    def run(command, args)
      case command
        when 'init'
          Contracto::Command::Init.new(args).execute
        when 'start'
          Contracto::Command::Start.new(args).execute
        when 'stop'
          Contracto::Command::Stop.new(args).execute
        when 'restart'
          Contracto::Command::Stop.new(args).execute
          Contracto::Command::Start.new(args).execute
      end
    end
  end
end