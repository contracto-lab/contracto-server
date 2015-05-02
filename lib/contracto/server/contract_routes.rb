class Contracto::Server < Sinatra::Base

  jsons_with_contracts = Dir["#{Contracto::Config.root_dir}/**/*.contract.json"].map do |file_with_contract|
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

end

