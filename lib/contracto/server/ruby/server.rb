require 'sinatra'

get '/contracto' do
  "*** Contracto server is working! [#{Gem::Specification.find_by_name('contracto').version}] ***"
end

require './contract.cdc.rb'

