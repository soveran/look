require "./lib/look"

Gem::Specification.new do |s|
  s.name              = "look"
  s.version           = Look::VERSION
  s.summary           = "Add a vendor directory to your load path."
  s.description       = "Add to your load path directories that respect the Ruby Packaging Standard (http://chneukirchen.github.com/rps/)"
  s.authors           = ["Michel Martens"]
  s.email             = ["michel@soveran.com"]
  s.homepage          = "http://github.com/soveran/look"
  s.files             = Dir["LICENSE", "README.markdown", "Rakefile", "lib/**/*.rb", "*.gemspec", "test/**/*.rb"]
end
