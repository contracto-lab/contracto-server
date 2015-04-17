require 'sinatra/base'

class Contracto::Server < Sinatra::Base
  require_relative '../../stats'

  set :port, Contracto::Constants::PORT

  get '/contracto' do
    "*** Contracto server is working! [#{Gem::Specification.find_by_name('contracto').version}] ***"
  end

  get '/contracto_terminate' do
    Thread.new { sleep 1; Process.kill 'INT', Process.pid }
    status 200
    body_on_terminate
  end

  jsons_with_contracts = Dir["#{Contracto::Config.root_dir}/**/*.con.json"].map do |file_with_contract|
    File.read file_with_contract
  end

  Contracto::Parser.new(jsons_with_contracts).contracts.each do |contract|
    send(contract.http_method, contract.url_pattern) do
      begin
        contract.response_body(params, http_headers)
      rescue StandardError => ex
        status 500
        error_response(ex)
      end
    end
  end

  def http_headers
    env.select {|k,v| k.start_with? 'HTTP_'}
  end

  def error_response(ex)
    ["#{ex.class}: #{ex.message}", ex.backtrace[0, 15].join("\n")].join("\n")
  end

  def body_on_terminate
    used_contracts_count = Contracto::Stats.used_contracts.size
    all_contracts_count = Contracto::Stats.all_contracts.size
    used_responses_count = Contracto::Stats.used_responses.size
    all_responses_count = Contracto::Stats.all_responses.size

    contracts_usage = if all_contracts_count.zero?
                        'N/A'
                      else
                        "#{(used_contracts_count / all_contracts_count.to_f).round(2)}%"
                      end

    responses_usage = if all_responses_count.zero?
                        'N/A'
                      else
                        "#{(used_responses_count / all_responses_count.to_f).round(2)}%"
                      end
    
    [
      "Used contracts: #{used_contracts_count}/#{all_contracts_count} (#{contracts_usage})",
      "Used responses: #{used_responses_count}/#{all_responses_count} (#{responses_usage})",
      ''
    ].join("\n")
  end
end

