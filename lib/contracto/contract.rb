class Contracto::Contract
  def initialize(hash)
    @hash = hash
    @request = Contracto::Contract::Request.new(@hash.fetch('request'))
  end

  def http_method
    @request.http_method
  end

  def url_pattern
    @request.url_pattern
  end

  def response_body(params)
    params.to_s
  end
  
  class Contracto::Contract::Request
    def initialize(hash)
      @hash = hash
    end

    def http_method
      @hash.fetch('http_method')
    end

    def url_pattern
      @hash.fetch('path')
    end
  end
end