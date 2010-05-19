Gem::Specification.new do |s|
  s.name              = "look"
  s.version           = "0.0.1"
  s.summary           = "Add a vendor directory to your load path."
  s.description       = "Add to your load path directories that respect the Ruby Packaging Standard (http://chneukirchen.github.com/rps/)"
  s.authors           = ["Michel Martens"]
  s.email             = ["michel@soveran.com"]
  s.homepage          = "http://github.com/soveran/look"
  s.files = ["LICENSE", "README.markdown", "Rakefile", "lib/look.rb", "look.gemspec", "test/gems/bar-0.0.1/lib/bar.rb", "test/look_test.rb", "test/test_helper.rb", "test/vendor/foo/lib/foo.rb"]
end
