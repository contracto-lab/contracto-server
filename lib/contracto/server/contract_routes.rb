require 'sinatra/base'

class Contracto::Server < Sinatra::Base

  contract_files = Dir["#{Contracto::Config.root_dir}/**/*.contract.json"]

  if contract_files.empty?
    puts "warning: no contracts found in #{Contracto::Config.root_dir}, create some *.contract.json files"
  end

  Contracto::Parser.new(contract_files).contracts.each do |contract|
    send(contract.http_method, contract.url_pattern) do
      contract_response = contract.response(params, http_headers)
      contract_response.body
    end
  end

  def http_headers
    env.select {|k,v| k.start_with? 'HTTP_'}
  end

end

