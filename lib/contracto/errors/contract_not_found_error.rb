require 'json'

class Contracto::ContractNotFoundError < StandardError
  def initialize(path, http_method)
    @path = path
    @http_method = http_method
  end

  def full_message
    [
      'Contract for following request does not exist: ' + "#{@http_method.upcase} #{@path}",
      'You can create contract for this request with following command:',
      '------------------',
      command,
      '------------------'
    ].join("\n") + "\n"
  end

  private

  def command
    [
      'touch ' + file_path,
      "echo '#{contract_json}' > #{file_path}",
      'touch ' + response_file_path,
      "echo \"Find me in #{response_file_path}\" > #{response_file_path}",
    ].join('; ')
  end

  def contract_json
    JSON.pretty_generate(request_to_contract)
  end

  def response_filename
    "#{@http_method.downcase}#{@path}".gsub('/', '_') + '.json'
  end

  def filename
    "#{@http_method.downcase}#{@path}".gsub('/', '_') + '.contract.json'
  end

  def file_path
    Contracto::Config.root_dir + '/' + filename
  end

  def response_file_path
    Contracto::Config.root_dir + '/' + response_filename
  end

  def request_to_contract
    {
      schema: {
        request: {
          method: @http_method,
          path: @path
        }
      },
      examples: [
        {
          response: {
            body_path: '/' + response_filename
          }
        }
      ]
    }
  end
end

