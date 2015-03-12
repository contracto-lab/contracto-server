require_relative 'sinatra-1.4.5/lib/sinatra'

require_relative '../contract.cdc'

get '/' do
  'Server is working!'
end