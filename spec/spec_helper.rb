require_relative '../lib/contracto'
require 'callapi'

Contracto::Config.root_dir = 'spec/fixtures'
Contracto::Command.run('start', [])

RSpec.configure do |config|
  config.before(:suite) do

    Callapi::Config.api_host = 'http://0.0.0.0:54321'
    Callapi::Config.log_level = :none

    Callapi::Routes.draw do
      get 'users'
      post 'users'
      get 'users/:id'
      get 'users/:id/posts'
    end
  end

  config.after(:suite) do
    Contracto::Command.run('stop', [])
  end
end
