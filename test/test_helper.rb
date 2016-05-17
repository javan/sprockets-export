require "minitest"
require "minitest/autorun"
require "sprockets"
require "sprockets/export"

class Sprockets::Export::TestCase < MiniTest::Test
  def self.test(name, &block)
    define_method("test_#{name.inspect}", &block)
  end
end
