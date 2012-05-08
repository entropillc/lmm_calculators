$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lmm_calculators/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lmm_calculators"
  s.version     = LmmCalculators::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of LmmCalculators."
  s.description = "TODO: Description of LmmCalculators."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.4"

  s.add_development_dependency "sqlite3"
end
