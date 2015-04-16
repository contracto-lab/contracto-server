class Contracto::Contract::Response

  include Contracto::Constants

  def initialize(hash)
    @hash = hash
  end

  def params
    @hash.fetch('request')['params'] || {}  #TODO: should it be optional or required?
  end

  def body_path
    @hash.fetch('response').fetch('body_path')
  end

  def params_matches?(other_params)
    return true if params.nil?

    params.keys.all? do |key|
      other_params[key] == params[key].to_s
    end
  end

  def headers_matches?(other_headers)
    return true if headers.empty?

    headers.keys.all? do |key|
      other_headers["HTTP_#{key.upcase}"] == headers[key]
    end
  end

  def body
    set_body
    @body.tap do
      replace_params_placeholders_with_params_value
    end
  end

  private

  def set_body
    @body = File.read(Contracto::Config.root_dir + body_path)
  end

  def replace_params_placeholders_with_params_value
    params.each do |key, value|
      @body.gsub!(":#{key}", value.to_s) if value
    end
  end
end
