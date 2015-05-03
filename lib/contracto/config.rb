class Contracto::Config
  extend Contracto::Constants

  class << self

    attr_accessor :repo_url

    def configure
      yield self if block_given?
    end

    def root_dir=(root_dir)
      @root_dir = "#{current_dir}/#{root_dir}"
    end

    def root_dir
      @root_dir || default_root_dir
    end

  end
end