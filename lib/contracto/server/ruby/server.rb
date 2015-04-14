require 'sinatra/base'

class Contracto::Server < Sinatra::Base

  set :port, Contracto::Constants::PORT

  get '/contracto' do
    "*** Contracto server is working! [#{Gem::Specification.find_by_name('contracto').version}] ***"
  end

  jsons_with_contracts = Dir["#{Contracto::Constants::ROOT_DIR}/**/*.con.json"].map do |file_with_contract|
    File.read file_with_contract
  end

  Contracto::Parser.new(jsons_with_contracts).contracts.each do |contract|
    send(contract.http_method, contract.url_pattern) do
      contract.response_body(params)
    end
  end

end

