class Contracto::Config
  extend Contracto::Constants

  class << self

    attr_accessor :repo_url
    attr_accessor :root_dir

    def configure
      yield self if block_given?
    end

    def root_dir
      @cached_root_dir ||= if @root_dir
        "#{current_dir}/#{@root_dir}"
      else
        default_root_dir
      end
    end

  end
end