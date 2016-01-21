# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ottinfra/sendmail/version'

Gem::Specification.new do |spec|
  spec.name          = "ottinfra-sendmail"
  spec.version       = OttInfra::Sendmail::VERSION
  spec.licenses      = ['MIT']
  spec.authors       = ["Dmitry Shmelev"]
  spec.email         = ["dmitry.shmelev@onetwotrip.com"]

  spec.summary       = %q{OTT Infra SendMail gem.}
  spec.description   = %q{Infrastructure libs for email notification.}
  spec.homepage      = "https://www.onetwotrip.com"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3.4', '>= 3.4.0'
  spec.add_development_dependency "rspec_junit_formatter", "~>0.2.3"
  spec.add_development_dependency "simplecov", "~>0.11.1"
  spec.add_dependency 'sendgrid-ruby', '~> 1.1', '>= 1.1.6'
  spec.add_dependency 'optimism', '~> 3.3', '>= 3.3.1'
end
