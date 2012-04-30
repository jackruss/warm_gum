# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'sinatra/warm_gum'

Gem::Specification.new do |s|
  s.name        = 'warm_gum'
  s.version     = Sinatra::WarmGum::VERSION
  s.authors     = ['Patrick Klingemann']
  s.email       = ['patrick.klingemann@gmail.com']
  s.homepage    = ''
  s.summary     = %q{A malleable human-to-human communication API}
  s.description = %q{A sinatra based API for messaging communication}

  s.rubyforge_project = "warm_gum"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib/sinatra']

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency 'sinatra'
end
