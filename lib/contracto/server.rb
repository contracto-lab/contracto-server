require 'sinatra/base'

class Contracto::Server < Sinatra::Base

  require_relative 'server/controller'
  require_relative 'server/contract_routes'
  require_relative 'stats'

  set :port, Contracto::Constants::PORT

  get '/contracto' do
    "*** Contracto server is working! [#{Gem::Specification.find_by_name('contracto').version}] ***"
  end

  get '/contracto/terminate' do
    Thread.new { sleep 1; Process.kill 'INT', Process.pid }
    status 200
    Contracto::Stats.summary
  end

end

