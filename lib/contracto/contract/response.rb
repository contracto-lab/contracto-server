class Contracto::Contract::Response

  include Contracto::Constants

  def initialize(hash)
    @hash = hash
  end

  def request
    @hash['request'] || {}
  end

  def params
    request['params'] || {}  #TODO: should it be optional or required?
  end

  def headers
    request['headers'] || {}  #TODO: should it be optional or required?
  end

  def body_path
    @hash.fetch('response').fetch('body_path')
  end

  def params_matches?(request_params)
    return true if params.empty?

    params.keys.all? do |key|
      value_from_contract = params[key]
      value_from_request = request_params[key]

      if value_from_contract.is_a?(Numeric)
        value_from_request = string_to_number(value_from_contract, value_from_request)
      end

      value_from_request == value_from_contract
    end
  end

  def headers_matches?(other_headers)
    return true if headers.empty?

    headers.keys.all? do |key|
      other_headers[human_header_key_to_http_header_key(key)] == headers[key]
    end
  end

  def conditions_number
    params.keys.size + headers.keys.size
  end

  def body
    set_body
    @body.tap do
      replace_params_placeholders_with_params_value
    end
  end

  private

  def string_to_number(number, string)
    if number.is_a?(Integer)
      string.to_i
    elsif number.is_a?(Float)
      string.to_f
    end
  end

  def set_body
    @body = File.read(Contracto::Config.root_dir + body_path)
  end

  def human_header_key_to_http_header_key(key)
    key = key.upcase
    key = key.gsub('-', '_')
    key = 'HTTP_' + key
    key
  end

  def replace_params_placeholders_with_params_value
    params.each do |key, value|
      @body.gsub!(":#{key}", value.to_s) if value
    end
  end
end
