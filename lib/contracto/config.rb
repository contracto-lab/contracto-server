class Contracto::Config
  class << self
    def repo_url=(repo_url)
      @repo_url = repo_url
    end

    def repo_url
      @repo_url
    end
  end
end