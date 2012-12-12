# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webcmd/version'

Gem::Specification.new do |gem|
  gem.name          = 'webcmd'
  gem.version       = Webcmd::VERSION
  gem.authors       = ['Sergey Nartimov']
  gem.email         = ['just.lest@gmail.com']
  gem.description   = %q{Run shell command through HTTP}
  gem.summary       = %q{Run shell command through HTTP}
  gem.homepage      = 'https://github.com/brainspec/webcmd'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency('rack', '~> 1.4.1')
  gem.add_dependency('puma', '~> 1.6.3')

  gem.add_development_dependency('rake')
  gem.add_development_dependency('rack-test')
end
