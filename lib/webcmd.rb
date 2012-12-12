require 'webcmd/server'

module Webcmd
  def self.run!
    Server.new.start
  end
end
