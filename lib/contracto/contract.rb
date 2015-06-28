class Contracto::Contract
  require_relative 'contract/request'
  require_relative 'contract/response'
  require_relative 'stats'

  attr_reader :responses

  def initialize(hash, file_path)
    @hash = hash
    @file_path = file_path
    @request   = Contracto::Contract::Request.new(@hash.fetch('schema').fetch('request'))
    @responses = Contracto::Contract::Responses.new(@hash.fetch('examples'))
  end

  def http_method
    @request.http_method.downcase
  end

  def url_pattern
    @request.url_pattern
  end

  def response(params, headers)
    @response = @responses.find_by_params_and_headers(params, headers)
    @response.tap do
      update_stats
      handle_missing_response(params, headers)
    end
  end

  def filename
    @filename ||= @file_path.split('/').last
  end

  private

  def handle_missing_response(params, headers)
    raise Contracto::ResponseNotFoundError.new(self, params, headers) unless @response
  end

  def update_stats
    if @response
      Contracto::Stats.used_contracts << self unless Contracto::Stats.used_contracts.include?(self)
      Contracto::Stats.used_responses << @response unless Contracto::Stats.used_responses.include?(@response)
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
      end
    end

    def count
      @responses.count
    end

    def map(&block)
      @responses.map(&block)
    end
  end
end
