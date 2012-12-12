require 'minitest/autorun'
require 'open-uri'

module Webcmd
  class IntegrationTest < MiniTest::Unit::TestCase
    def test_run_bin_file
      bin = File.expand_path('../../bin/webcmd', __FILE__)
      env = {'COMMAND' => 'echo "foobar"', 'TOKEN' => '1234'}
      pipe = IO.popen([env, bin, err: [:child, :out]])

      assert_equal 'foobar', response.strip
    ensure
      Process.kill('KILL', pipe.pid)
    end

    private

    def response
      retries ||= 3
      sleep 0.5
      response = open("http://127.0.0.1:9292/?token=1234").read
    rescue Errno::ECONNREFUSED => e
      retries -= 1
      retries > 0 ? retry : raise(e)
    end
  end
end
