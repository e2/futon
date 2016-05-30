source 'https://rubygems.org'

gemspec development_group: :gem_tools

group :gem_tools do
end

unless ENV['IN_DOCKER']
  group :test do
    gem 'rspec', '~> 3.4'
  end

  group :development do
    gem 'guard', '~> 2.14'
    gem 'guard-rspec', '~> 4.7'
    gem 'guard-yield', '~> 0.1'
    gem 'guard-rubocop'
    gem 'rspec', '~> 3.4'
  end
end
