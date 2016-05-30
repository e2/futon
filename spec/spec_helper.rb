require 'nenv'
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run focus: !Nenv.ci?
  config.run_all_when_everything_filtered = true

  # config.example_status_persistence_file_path = "spec/examples.txt"

  config.disable_monkey_patching!

  config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.profile_examples = 2

  # config.order = :random

  Kernel.srand config.seed

  config.before do
    allow(File).to receive(:expand_path) do |*args|
      raise "stub called: File.expand_path(#{args.map(&:inspect).join(',')})"
    end

    require 'yaml'
    allow(YAML).to receive(:load_file) do |*args|
      raise "stub called: YAML.load_path(#{args.map(&:inspect).join(',')})"
    end

    allow(Kernel).to receive(:system) do |*args|
      raise "stub called: Kernel.system(#{args.map(&:inspect).join(',')})"
    end
  end
end
