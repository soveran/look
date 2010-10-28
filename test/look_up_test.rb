require File.join(File.dirname(__FILE__), "test_helper")

class TestLook < Test::Unit::TestCase
  context "finding libraries" do

    should "raise an error if a directory is not provided" do
      assert_raises ArgumentError do
        Look.up
      end
    end

    Look.at_vendor File.dirname(__FILE__)

    should "find foo.rb file in vendor directory" do
      file = Look.up('foo.rb').first
      assert_equal(file, File.expand_path(File.dirname(__FILE__) + '/vendor/foo/lib/foo.rb'))
    end
  end

end
