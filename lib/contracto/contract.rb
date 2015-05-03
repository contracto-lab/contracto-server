class Contracto::Contract
  require_relative 'contract/request'
  require_relative 'contract/response'
  require_relative 'stats'

  attr_reader :responses

  def initialize(hash)
    @hash = hash
    @request   = Contracto::Contract::Request.new(@hash.fetch('schema').fetch('request'))
    @responses = Contracto::Contract::Responses.new(@hash.fetch('examples'))
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
    response.body.tap do
      Contracto::Stats.used_contracts << self unless Contracto::Stats.used_contracts.include?(self)
    end
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
      end.tap do |response|
        Contracto::Stats.used_responses << response if response && !Contracto::Stats.used_responses.include?(response)
      end
    end

    def count
      @responses.count
    end
  end
end
