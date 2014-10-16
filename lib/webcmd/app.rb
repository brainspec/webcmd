require 'webcmd/command_runner'

module Webcmd
  class App
    def initialize(options={})
      @command = options[:command]
      @token   = options[:token]
    end

    def call(env)
      req = Rack::Request.new(env)
      if token_valid?(req)
        [200, {'Content-Type' => 'text/plain'}, CommandRunner.new(@command, req.params)]
      else
        [403, {'Content-Type' => 'text/plain'}, ['Token invalid']]
      end
    end

    private

    def token_valid?(req)
      req.params['token'] == @token
    end
  end
end
