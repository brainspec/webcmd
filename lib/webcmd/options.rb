require 'optparse'
require 'forwardable'

module Webcmd
  class Options
    extend Forwardable

    def initialize(argv)
      @parser = OptionParser.new(argv) do |opts|
        opts.banner = "Usage: webcmd [options]"

        opts.on '-o', '--host HOST', 'listen on HOST (default: 0.0.0.0)' do |host|
          options[:Host] = host
        end

        opts.on '-p', '--port PORT', 'use PORT (default: 9292)' do |port|
          @options[:Port] = port
        end

        opts.on '-t', '--threads INT', 'min:max threads to use (default 0:1)' do |threads|
          @options[:Threads] = threads
        end

        opts.on '-D', '--daemonize', 'run daemonized in the background' do |d|
          @options[:daemonize] = !!d
        end

        opts.on_tail '-h', '--help', 'show this message' do
          puts opts
          exit
        end

        opts.on_tail '--version', 'show version' do
          puts "webcmd #{Webcmd::VERSION}"
          exit
        end
      end
    end

    def parse!
      @options = { app: {} }
      @parser.parse!
      @options[:app][:command] = ENV['COMMAND']
      @options[:app][:token]   = ENV['TOKEN']

      @options
    end
  end
end
