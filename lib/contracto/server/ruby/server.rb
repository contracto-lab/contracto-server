require 'sinatra/base'

class Contracto::Server < Sinatra::Base

  set :port, Contracto::Constants::PORT

  get '/contracto' do
    "*** Contracto server is working! [#{Gem::Specification.find_by_name('contracto').version}] ***"
  end

  jsons_with_contracts = Dir["#{Contracto::Config.root_dir}/**/*.con.json"].map do |file_with_contract|
    File.read file_with_contract
  end

  Contracto::Parser.new(jsons_with_contracts).contracts.each do |contract|
    send(contract.http_method, contract.url_pattern) do
      begin
        contract.response_body(params, headers)
      rescue StandardError => ex
        status 500
        error_response(ex)
      end
    end
  end


  def error_response(ex)
    ["#{ex.class}: #{ex.message}", ex.backtrace[0, 15].join("\n")].join("\n")
  end
end

