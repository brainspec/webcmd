require 'minitest/autorun'
require 'rack/test'
require 'webcmd'

module Webcmd
  class AppTest < MiniTest::Unit::TestCase
    include Rack::Test::Methods

    def options
      @options ||= {}
    end

    def app
      App.new(options)
    end

    def test_success_response
      get '/'
      assert_equal 200, last_response.status
    end

    def test_returns_text_content_type
      get '/'
      assert_equal 'text/plain', last_response.content_type
    end

    def test_returns_command_output
      options[:command] = 'echo "foobar"'
      get '/'
      assert_equal 200, last_response.status
      assert_equal 'foobar', last_response.body.strip
    end

    def test_executes_command_in_bundler_free_env
      options[:command] = 'export | grep BUNDLE_ | grep -v grep'
      get '/'
      assert_empty last_response.body.strip
    end

    def test_returns_command_stderr
      options[:command] = 'echo "foobar" >&2'
      get '/'
      assert_equal 200, last_response.status
      assert_equal 'foobar', last_response.body.strip
    end

    def test_invalid_token
      options[:token] = 'asdf'
      get '/', token: '1234'
      assert_equal 403, last_response.status
    end

    def test_pass_env_var
      options[:command] = 'echo $WEBCMD_TEST_VAR'
      get '/', test_var: 'test'
      assert_equal 'test', last_response.body.strip
    end
  end
end
