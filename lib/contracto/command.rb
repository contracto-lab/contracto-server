class Contracto::Command
  class << self

    def run(command, args)
      case command
        when 'init'
          Contracto::Installer.new(args).execute
        when 'run'
          Contracto::Runner.new(args).execute
      end
    end
  end
end