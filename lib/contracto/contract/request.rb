class Contracto::Contract::Request
  def initialize(hash)
    @hash = hash
  end

  def http_method
    @hash.fetch('method')
  end

  def url_pattern
    PathToSinatraPathAdapter.new(@hash.fetch('path')).sinatra_path
  end

  class PathToSinatraPathAdapter
    def initialize(path)
      @path = path
    end

    def sinatra_path
      parse_brackets! if path_with_brackets?
      @path
    end

    private

    def parse_brackets!
      if fully_dynamic_route?
        path_to_regexp!
      else
        brackets_to_colons!
      end
    end

    def brackets_to_colons!
      @path.gsub!('{', ':')
      @path.gsub!('}', '')
    end

    def path_to_regexp!
      brackets_to_named_captures!
      @path = Regexp.new(@path)
    end

    def brackets_to_named_captures!
      matches = @path.scan(/(\{([^\/])*\})/).map(&:first)
      matches.each do |match|
        @path.gsub! match, "(?<#{match}>\\w*)"
      end
      @path.gsub!('{', '')
      @path.gsub!('}', '')
    end

    def fully_dynamic_route?
      !@path.scan(/\}[^\/]/).empty? || !@path.scan(/[^\/]\{/).empty?
    end

    def path_with_brackets?
      !!@path.match('{')
    end
  end
end
