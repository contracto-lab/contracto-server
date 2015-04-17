class Contracto::Stats
  class << self
    attr_accessor :all_contracts

    def used_contracts
      @used_contracts ||= []
    end

    def used_responses
      @used_responses ||= []
    end

    def all_responses
      @all_responses ||= all_contracts.map(&:responses).map(&:count).inject(&:+)
    end
  end
end