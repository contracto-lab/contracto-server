class Contracto::Command
  class << self

    def run(command, args)
      case command
        when 'init'
          Contracto::Installer.new(args).execute
        when 'start'
          Contracto::Runner.new(args).execute
        when 'stop'
          Contracto::Terminator.new(args).execute
      end
    end
  end
end