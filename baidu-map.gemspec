# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'baidu-map/version'

Gem::Specification.new do |spec|
  spec.name          = "baidu-map"
  spec.version       = BaiduMap::VERSION
  spec.authors       = ["inetufo"]
  spec.email         = ["inetufo@163.com"]
  spec.description   = %q{baidu map ruby wrapper}
  spec.summary       = %q{baidu map ruby wrapper}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
