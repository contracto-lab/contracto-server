require 'json'

class Contracto::ResponseNotFoundError < StandardError
  def initialize(contract, params, headers)
    @contract, @params, @headers = contract, params, headers
  end

  def full_message
    [
      "Contract does not contain example for following params:\n#{pretty_formatted_params}",
      'Existing examples cover following set of params:',
      pretty_formatted_examples_params
    ].join("\n\n") + "\n"
  end

  private

  def pretty_formatted_params
    JSON.pretty_generate(@params)
  end

  def pretty_formatted_examples_params
    i = 0
    examples_params.map do |params|
      i += 1
      "example #{i}\n" + JSON.pretty_generate(params) + "\n"
    end.join("\n")
  end

  def examples_params
    @contract.responses.map(&:params)
  end
end
