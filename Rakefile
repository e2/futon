require 'nenv'
require 'bundler/gem_tasks'

default_tasks = []

unless ENV['IN_DOCKER']
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.verbose = Nenv.ci?
  end

  unless Nenv.ci?
    require 'rubocop/rake_task'
    default_tasks << RuboCop::RakeTask.new(:rubocop)
  end

  task default: default_tasks.map(&:name)
end
