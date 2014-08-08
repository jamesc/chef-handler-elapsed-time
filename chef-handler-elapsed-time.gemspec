Gem::Specification.new do |s|
  s.name = 'chef-handler-elapsed-time'
  s.version = '0.1.4'
  s.platform = Gem::Platform::RUBY
  s.summary = "Chef report handler to graphically display time spend in each resource during the Chef Run"
  s.description = "Chef report handler to graphically display time spend in each resource during the Chef Run. Outputs the time as ASCII bar chart at end of run."
  s.author = "James Casey"
  s.email = "jamesc.000@gmail.com"
  s.homepage = "https://github.com/jamesc/chef-handler-elapsed-time"
  s.require_path = 'lib'
  s.files = %w(LICENSE README.md) + Dir.glob("lib/**/*")
end
