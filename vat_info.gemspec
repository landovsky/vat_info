# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vat_info/version'

Gem::Specification.new do |spec|
  spec.name          = 'payer_vat_info'
  spec.version       = VatInfo::VERSION
  spec.authors       = ['Tomas Landovsky']
  spec.email         = ['landovsky@gmail.com']

  spec.summary       = ''
  spec.description   = 'Using mfcr.cz SOAP API to get information about Czech VAT payers.'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'savon'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
