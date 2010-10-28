Gem::Specification.new do |s|
  s.name              = "look"
  s.version           = "0.1.0"
  s.summary           = "Add a vendor directory to your load path."
  s.description       = "Add to your load path directories that respect the Ruby Packaging Standard (http://chneukirchen.github.com/rps/)"
  s.authors           = ["Michel Martens"]
  s.email             = ["michel@soveran.com"]
  s.homepage          = "http://github.com/soveran/look"
  s.files = ["LICENSE", "README.md", "Rakefile", "lib/look.rb", "look.gemspec", "test/vendor/foo/lib/foo.rb", "test/look_up_test.rb", "test/test_helper.rb", "test/look_at_test.rb", "test/gems/bar-0.0.1/lib/bar.rb"]
end
