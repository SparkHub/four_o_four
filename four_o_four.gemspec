# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'four_o_four'
  spec.version       = '0.0.1'
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
  spec.homepage      = 'https://github.com/esparta/four_o_four'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    fail <<-FAIL
      RubyGems 2.0 or newer is required to protect against public gem pushes.
    FAIL
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rack'
  spec.add_dependency 'activesupport'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-nc'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-remote'
  spec.add_development_dependency 'pry-nav'
  #spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
