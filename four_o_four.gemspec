# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'four_o_four'
  spec.version       = '0.0.3'
  spec.authors       = ['Espartaco Palma']
  spec.email         = ['esparta@gmail.com']

  spec.summary       = <<-SUMMARY
    FourOFour, a simple Rack middleware to handle 404 responses with delegation
  SUMMARY
  spec.description = <<-DESCRIPTION
    With FourOFour you will be able to handle your 404 responses and change
    how your application behave dynamically and with the 'right' way: using a
    class for a delegation, separating all the concerns. Routes and logic should
    have their own space.
  DESCRIPTION
  spec.homepage      = 'https://github.com/SparkHub/four_o_four'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rack', '~> 1.6.0'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-nc', '~> 0.2.1'
  spec.add_development_dependency 'listen', '~> 3.0.6'
  spec.add_development_dependency 'guard', '~> 2.13.0'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'pry-nav'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
