$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lmm_calculators/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lmm_calculators"
  s.version     = LmmCalculators::VERSION
  s.authors     = ["Nicholas W. Watson"]
  s.email       = ["nick@entropi.co"]
  s.homepage    = "http://github.com/entropillc/lmm_calculators"
  s.summary     = "Custom Spree Shipping Calculators"
  s.description = "Custom Spree Shipping Calculators."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.3"

  s.add_development_dependency "sqlite3"
end
