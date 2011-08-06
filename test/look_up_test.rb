require File.join(File.dirname(__FILE__), "test_helper")

describe "finding libraries using Look.up" do

  fixture_directory = File.expand_path(
    File.join(File.dirname(__FILE__), 'fixtures', 'up')
  )

  it "should raise an error if a directory is not provided" do
    assert_raises ArgumentError do
      Look.up
    end
  end

  it "should find foo.rb file in vendor directory" do
    Look.at fixture_directory, 'vendor', 'fup', 'lib'

    file = Look.up('fup.rb').first
    assert_equal(file, fixture_directory + '/vendor/fup/lib/fup.rb')
  end

end

