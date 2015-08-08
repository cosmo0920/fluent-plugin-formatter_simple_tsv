# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-formatter_simple_tsv"
  spec.version       = "0.0.2"
  spec.authors       = ["Hiroshi Hatake"]
  spec.email         = ["cosmo0920.oucc@gmail.com"]

  spec.summary       = "Fluentd Simple TSV formatter plugin"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/cosmo0920/fluent-plugin-formatter_simple_tsv"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "fluentd", [">= 0.12.0", "< 2"]
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit", ">= 3.1.0"
end
