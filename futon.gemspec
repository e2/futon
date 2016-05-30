# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'futon/version'

Gem::Specification.new do |spec|
  spec.name          = 'futon'
  spec.version       = Futon::VERSION
  spec.authors       = ['Cezary Baginski']
  spec.email         = ['cezary@chronomantic.net']

  spec.summary       = 'Makes your workspaces like a futon'
  spec.description   = 'Restores/backups your repositories/workspaces based'\
                       ' on what you need right now'
  spec.homepage      = 'http://github.com/e2/futon'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # msg = 'RubyGems >= 2.0 needed to protect against public gem pushes.'
  # raise msg unless spec.respond_to?(:metadata)

  # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  # spec.files = `git ls-files -z`.split("\x0").reject do |f|
  #   f.match(%r{^(test|spec|features)/})
  # end
  spec.files = [
    'README.md',
    'LICENSE.txt',
    'lib/futon.rb',
    'lib/futon/cli.rb',
    'lib/futon/configuration.rb',
    'lib/futon/workspace.rb',
    'lib/futon/workspace/provider.rb',
    'lib/futon/workspace/provider/git.rb',
    'lib/futon/os.rb',
    'exe/futon'
  ]
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'nenv', '~> 0.3'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 11.1'
end
