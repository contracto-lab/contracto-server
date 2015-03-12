require 'fileutils'

class Contracto::Command
  class << self

    def run(command, args)
      case command
        when 'install'
          FileUtils.rm_rf 'contracto'
          FileUtils.cp_r "#{gem_dir}/lib/contracto/server/ruby", 'contracto_'
          FileUtils.mv 'contracto_', 'contracto'
          unless File.exist? 'contract.cdc.rb'
            FileUtils.mv 'contracto/contract.cdc.rb', '.'
            puts 'created: contract.cdc.rb'
          end

        when 'run'
          system 'rackup contracto/config.ru'
      end
    end

    def gem_dir
      @gem_dir ||= Gem::Specification.find_by_name('contracto').gem_dir
    end
  end
end