require 'rack'
require 'webcmd/app'
require 'webcmd/options'

module Webcmd
  class Server
    def wrapped_app
      @wrapped_app ||= begin
        app = App.new(options[:app])

        Rack::Builder.new do
          use Rack::Logger
          use Rack::CommonLogger
          use Rack::Chunked
          run app
        end
      end
    end

    def default_options
      {
        Host: '0.0.0.0',
        Port: 9292,
        environment: 'production',
        server: :puma,
        Threads: '0:1'
      }
    end

    def options
      @options ||= begin
        options = Options.new(ARGV).parse!
        default_options.merge(options)
      end
    end

    def start
      Rack::Server.start options.merge(app: wrapped_app)
    end
  end
end
