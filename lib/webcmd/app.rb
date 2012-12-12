require 'webcmd/command_runner'

module Webcmd
  class App
    def initialize(options={})
      @command = options[:command]
      @token   = options[:token]
    end

    def call(env)
      if token_valid?(env)
        [200, {'Content-Type' => 'text/plain'}, CommandRunner.new(@command)]
      else
        [403, {'Content-Type' => 'text/plain'}, ['Token invalid']]
      end
    end

    private

    def token_valid?(env)
      req = Rack::Request.new(env)
      req.params['token'] == @token
    end
  end
end
