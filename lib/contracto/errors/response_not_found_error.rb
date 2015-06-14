require 'json'

class Contracto::ResponseNotFoundError < StandardError
  def initialize(contract, params, headers)
    @contract, @params, @headers = contract, params, headers
  end

  def full_message
    [
      'Contract does not contain example for following params:',
      pretty_formatted_params,
      'and (or) headers:',
      pretty_formatted_headers,
      "Please update #{@contract.file_path}"
    ].join("\n") + "\n"
  end

  private

  def pretty_formatted_params
    return '(NO PARAMS)' if @params.empty?
    JSON.pretty_generate(@params)
  end

  def pretty_formatted_headers
    JSON.pretty_generate(@headers)
  end

  def examples_params
    @contract.responses.map(&:params)
  end
end
