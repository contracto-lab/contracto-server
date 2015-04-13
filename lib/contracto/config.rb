class Contracto::Config
  extend Contracto::Constants

  class << self

    attr_accessor :repo_url

    def configure
      yield self if block_given?
    end

    def repo_url
    end

  end
end