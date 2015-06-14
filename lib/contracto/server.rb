require 'sinatra/base'

class Contracto::Server < Sinatra::Base

  require_relative 'stats'

  set :port, Contracto::Constants::PORT
  set :show_exceptions, false

  get '/contracto' do
    "*** Contracto server is working! [#{Gem::Specification.find_by_name('contracto').version}] ***"
  end

  get '/contracto/terminate' do
    Thread.new { sleep 1; Process.kill 'INT', Process.pid }
    status 200
    Contracto::Stats.summary rescue ''
  end

  not_found do
    begin
      Contracto::ContractNotFoundError.new(request.path_info, request.request_method).full_message
    rescue StandardError => ex
      unexpected_error_message(ex)
    end
  end

  error Contracto::ResponseNotFoundError do |ex|
    status 404
    ex.full_message
  end

  error do |ex|
    status 500
    unexpected_error_message(ex)
  end

  def unexpected_error_message(ex)
    ["#{ex.class}: #{ex.message}", ex.backtrace[0, 15].join("\n")].join("\n")
  end
end

