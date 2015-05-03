class Contracto::Server < Sinatra::Base

  jsons_with_contracts = Dir["#{Contracto::Config.root_dir}/**/*.contract.json"].map do |file_with_contract|
    File.read file_with_contract
  end

  if jsons_with_contracts.empty?
    puts "warning: no contracts found in #{Contracto::Config.root_dir}, create some *.contract.json files"
  end

  Contracto::Parser.new(jsons_with_contracts).contracts.each do |contract|
    send(contract.http_method, contract.url_pattern) do
      contract.response_body(params, http_headers)
    end
  end

  def http_headers
    env.select {|k,v| k.start_with? 'HTTP_'}
  end

end

