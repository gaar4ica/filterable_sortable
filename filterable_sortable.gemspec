# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filterable_sortable/version'

Gem::Specification.new do |s|
  s.name          = "filterable_sortable"
  s.version       = FilterableSortable::VERSION
  s.authors       = ["Anna Kazakova (gaar4ica)"]
  s.email         = ["gaar4ica@gmail.com"]
  s.description   = 'Gem generates :filtered and :sorted scopes, can be easily used for building admin zone or other filterable sortable architecture.'
  s.summary       = 'Model-based filterable and sortable functionality.'
  s.homepage      = "https://github.com/gaar4ica/filterable_sortable"
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|s|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
  s.add_dependency 'activesupport'
end
