require 'json'

class Contracto::Parser
  def initialize(strings_with_json)
    @json_collection = strings_with_json.map { |string| JSON.parse(string) }
  end

  def contracts
    @json_collection.map do |json|
      Array(json).map do |json|
        Contracto::Contract.new(json)
      end
    end.flatten
  end
end