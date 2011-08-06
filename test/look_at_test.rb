require File.join(File.dirname(__FILE__), "test_helper")

describe "loading libraries with Look.at" do

  fixture_directory = File.expand_path(
    File.join(File.dirname(__FILE__), 'fixtures', 'at')
  )

  it "should raise an error if a directory is not provided" do
    assert_raises ArgumentError do
      Look.at
    end

    # NOTE: this requirement was removed b/c it may be possible
    # that a path that exists on one system might not exist on 
    # another, but the program should work in either case.

    #assert_raises ArgumentError do
    #  Look.at "nonexistent_directory"
    #end
  end

  it "should find the library once Look.at is executed" do
    assert_raises LoadError do
      require "fat"
    end

    Look.at fixture_directory, 'vendor'

    require "fat"

    assert_equal "Fat in vendor/fat/lib", Fat
  end

end
