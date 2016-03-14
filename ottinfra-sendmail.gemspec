# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'ottinfra-sendmail'
  spec.version       = '0.0.1'
  spec.licenses      = ['MIT']
  spec.authors       = ['Dmitry Shmelev']
  spec.email         = ['dmitry.shmelev@onetwotrip.com']

  spec.summary       = 'OTT Infra SendMail gem.'
  spec.description   = 'Infrastructure libs for email notification.'
  spec.homepage      = 'https://www.onetwotrip.com'

  spec.add_dependency 'sendgrid-ruby', '~> 1.1', '>= 1.1.6'
end
