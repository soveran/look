module Look
  # Current version of Look.
  VERSION = "0.2.0"
end

if RUBY_VERSION > '1.9'
  require_relative 'look/at'
  require_relative 'look/in'
  require_relative 'look/up'
else
  require 'look/at'
  require 'look/in'
  require 'look/up'
end

