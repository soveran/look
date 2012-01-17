require File.expand_path("./helper", File.dirname(__FILE__))

scope do
  test "raise an error if a directory is not provided" do
    assert_raise ArgumentError do
      Look.at
    end

    assert_raise ArgumentError do
      Look.at "nonexistent_directory"
    end
  end

  test "find the library once Look.at is executed" do
    begin
      require "foo"
    rescue LoadError
    end

    Look.at File.dirname(__FILE__)

    require "foo"
  end

  test "load the file in vendor" do
    Look.at File.dirname(__FILE__)

    require "foo"

    assert_equal "Foo in vendor/foo/lib", Foo
  end

  test "accept a custom glob" do
    Look.at File.dirname(__FILE__), "gems/*/lib"

    require "bar"

    assert_equal "Bar in gems/bar-0.0.1/lib", Bar
  end
end
