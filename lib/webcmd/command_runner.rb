module Webcmd
  class CommandRunner
    def initialize(command)
      @command = command
    end

    def each(&block)
      IO.popen([shell_env, 'bash', '-l', err: [:child, :out]], 'w+') do |shell|
        shell.write @command
        shell.close_write
        shell.each_line(&block)
      end
    end

    private

    def shell_env
      Hash[ENV.keys.grep(/^BUNDLE_/).map { |k| [k, nil] }]
    end
  end
end
