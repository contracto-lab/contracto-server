require './contracto/server'

set :run, false
set :environment, :production
run Sinatra::Application