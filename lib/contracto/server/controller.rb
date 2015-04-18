require 'daemons'
require 'net/http'
require 'uri'

class Contracto::Server < Sinatra::Base

  extend Contracto::Constants

  class << self

    def start_contracto_server!
      if contracto_server_running?
        puts 'contracto server is already running, enter "contracto stop" to kill it'
        return
      end

      start_daemon!
      wait_until_server_is_running
    end

    def stop_contracto_server!
      uri = URI.parse("http://localhost:#{port}/contracto/terminate")
      response = Net::HTTP.get_response(uri)
      if response.is_a?(Net::HTTPOK)
        puts 'contracto server killed'
        puts response.body
      else
        puts "something went wrong: [#{response.code}] #{response.body}]"
      end
    rescue Errno::ECONNREFUSED
      puts 'contracto server could not be killed (already dead or was never alive)'
    end

    private

    def contracto_server_running?
      uri = URI.parse("http://localhost:#{port}/contracto")
      Net::HTTP.get_response(uri).is_a?(Net::HTTPOK)
    rescue Errno::ECONNREFUSED
      false
    end

    def start_daemon!
      Daemons.call(app_name: server_pidfile_name, dir: Contracto::Config.root_dir, dir_mode: :normal) do
        Contracto::Server.run!
      end
    end

    def wait_until_server_is_running
      5.downto(0).each do |n|
        sleep 1
        puts "waiting for contracto server, #{n} tries left..."
        break if contracto_server_running?
      end
    end
  end

end

