require File.join(File.dirname(__FILE__), "test_helper")

describe "loading libraries using Look.in" do

  fixture_directory = File.expand_path(
    File.join(File.dirname(__FILE__), 'fixtures', 'in')
  )

  it "should raise an error if a directory is not provided" do
    assert_raises ArgumentError do
      Look.in
    end

    # NOTE: this requirement was removed b/c it may be possible
    # that a path that exists on one system might not exist on 
    # another, but the program should work in either case.

    #assert_raises ArgumentError do
    #  Look.at "nonexistent_directory"
    #end
  end

  it "should find the library once Look.in is executed" do
    assert_raises LoadError do
      require "fin"
    end

    Look.in fixture_directory, 'vendor', 'fin', 'lib'

    require "fin"
  end

  it "should accept a custom glob" do
    Look.in fixture_directory, "gems/*/lib"

    require "bar"

    assert_equal "Bar in gems/bar-0.0.1/lib", Bar
  end

end

