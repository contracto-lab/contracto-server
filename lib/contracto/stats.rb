class Contracto::Stats

  NA_TEXT = 'N/A'

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

    def contracts_usage
      return NA_TEXT if all_contracts.size.zero?

      (used_contracts.size/all_contracts.size.to_f).round(2)
    end

    def responses_usage
      return NA_TEXT if all_responses.size.zero?

      (used_responses.size/all_responses.size.to_f).round(2)
    end
    
    def contracts_stats_summary
      "contracts usage: #{used_contracts.size}/#{all_contracts.size} (#{contracts_usage}%)"
    end

    def responses_stats_summary
      "responses usage: #{used_responses.size}/#{all_responses.size} (#{responses_usage}%)"
    end

    def summary
      length = contracts_stats_summary.length
      [
        'stats'.center(length, '-'),
        contracts_stats_summary,
        responses_stats_summary,
        ('-' * length) + ' '
      ].join("\n")
    end
  end
end