require 'json'

class Contracto::Parser
  require_relative 'stats'

  def initialize(contract_files)
    @contract_files = contract_files
  end

  def contracts
    @contract_files.map(&method(:create_contract_from_file)).flatten.tap do |contracts|
      Contracto::Stats.all_contracts = contracts
    end
  end

  private

  def create_contract_from_file(file_path)
    parsed_json = JSON.parse(File.read(file_path))
    parsed_json = [parsed_json] unless parsed_json.is_a?(Array)

    parsed_json.map do |hash|
      Contracto::Contract.new(hash, file_path)
    end
  end

end
