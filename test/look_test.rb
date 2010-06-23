require File.join(File.dirname(__FILE__), "test_helper")

class TestLook < Test::Unit::TestCase
  context "loading libraries" do

    should "raise an error if a directory is not provided" do
      assert_raises ArgumentError do
        Look.at
      end

      assert_raises ArgumentError do
        Look.at "nonexistent_directory"
      end
    end

    should "find the library once Look.at is executed" do
      assert_raises LoadError do
        require "foo"
      end

      Look.at File.dirname(__FILE__)

      assert_nothing_raised do
        require "foo"
      end
    end

    should "load the file in vendor" do
      Look.at File.dirname(__FILE__)

      require "foo"

      assert_equal "Foo in vendor/foo/lib", Foo
    end

    should "accept a custom glob" do
      Look.at File.dirname(__FILE__), "gems/*/lib"

      require "bar"

      assert_equal "Bar in gems/bar-0.0.1/lib", Bar
    end
  end
end
