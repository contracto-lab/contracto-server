require 'sinatra'
require 'contracto'

get '/contracto' do
  "*** Contracto server is working! [#{Gem::Specification.find_by_name('contracto').version}] ***"
end

json_string = File.read Contracto::CONTRACT_FILENAME
json_strings = [json_string]

Contracto::Parser.new(json_strings).contracts.each do |contract|
  send(contract.http_method, contract.url_pattern) do
    contract.response_body(params)
  end
end


