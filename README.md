# Webcmd

Run shell command through HTTP.

## Installation

    $ gem install webcmd

## Usage

Use `COMMAND` environment variable to specify the command to be runned and `TOKEN` to protect the HTTP endpoint, e.g.:

    $ COMMAND="echo it\'s working" TOKEN="1234" webcmd
    Puma 1.6.3 starting...
    * Min threads: 0, max threads: 1
    * Environment: production
    * Listening on tcp://0.0.0.0:9292

You could run `curl` in other terminal to check whether it's working:

    $ curl http://localhost:9292/\?token=1234
    it's working

To list available command-line options run:

    $ webcmd -h

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
