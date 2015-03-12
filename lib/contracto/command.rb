class Contracto::Command
  class << self

    def run(command, args)
      case command
        when 'install'
          Contracto::Installer.new(args).execute
        when 'run'
          system 'rackup contracto/config.ru'
      end
    end
  end
end