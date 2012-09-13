$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "app_config"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "app_config"
  s.version     = AppConfig::VERSION
  s.authors     = ["Dan de Havilland"]
  s.email       = ["dan+dev@dandehavilland.com"]
  s.homepage    = "http://www.dandehavilland.com/"
  s.summary     = "A simple, reusable class for accessing configuration variables in YAML files"
  s.description = s.description

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "rspec"
end
