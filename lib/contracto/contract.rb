class Contracto::Contract
  require_relative 'contract/response'

  def initialize(hash)
    @hash = hash
    @request   = Contracto::Contract::Request.new(@hash.fetch('request'))
    @responses = Contracto::Contract::Responses.new(@hash.fetch('responses'))
  end

  def http_method
    @request.http_method
  end

  def url_pattern
    @request.url_pattern
  end

  def response_body(params, headers)
    response = @responses.find_by_params_and_headers(params, headers)
    raise Contracto::ResponseNotFoundError.new(params) unless response
    response.body
  end

  class Contracto::Contract::Responses
    def initialize(responses)
      @responses = responses.map do |response|
        Contracto::Contract::Response.new(response)
      end.sort_by(&:conditions_number).reverse
    end

    def find_by_params_and_headers(params, headers)
      @responses.find do |response|
        response.params_matches?(params) && response.headers_matches?(headers)
      end
    end
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