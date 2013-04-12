# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "coffee-script-debugger/version"

Gem::Specification.new do |s|
  s.name        = "coffee-script-debugger"
  s.version     = CoffeeScriptDebugger::VERSION
  s.authors     = ["Gary Taylor", "Andrey Vokin"]
  s.email       = ["gary.taylor@hismessages.com"]
  s.homepage    = ""
  s.summary     = "Gem for debugging CoffeeScript in Rails applications"
  s.description = "Gem for debugging CoffeeScript in Rails applications"

  s.rubyforge_project = "coffee-script-debugger"

  s.files = Dir["README.md", "LICENSE", "lib/**/*.rb"]
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = ["coffee-script-debugger"]
  s.require_paths = ["lib"]

  s.add_dependency 'coffee-script'
  s.add_dependency 'coffee-script-source'
  s.add_dependency "sprockets"
  s.add_dependency "execjs"
end
