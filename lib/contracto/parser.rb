require 'json'

class Contracto::Parser
  require_relative 'stats'

  def initialize(strings_with_json)
    @json_collection = strings_with_json.map { |string| JSON.parse(string) }
  end

  def contracts
    @json_collection.map do |json|
      json = [json] unless json.is_a?(Array)
      json.map do |json|
        Contracto::Contract.new(json)
      end
    end.flatten.tap do |contracts|
      Contracto::Stats.all_contracts = contracts
    end
  end
end