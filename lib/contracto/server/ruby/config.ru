require File.expand_path('../server', __FILE__)   # hack for replacing #require_relative (see config.ru require_relative issue)

set :run, false
set :environment, :development
run Sinatra::Application