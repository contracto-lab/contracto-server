require_relative 'sinatra-1.4.5/lib/sinatra'

begin
  require_relative '../contract.rb'
rescue LoadError
  warn 'Could not found any contract'
end

get '/' do
  'Server is working!'
end