require 'futon/workspace'
require 'yaml'

module Futon
  class Configuration
    class Error < RuntimeError
      class NoWorkspaces < Error
      end
    end

    def initialize
      options = load_from(default_config_file)

      @workspaces = setup_workspaces(options)
    end

    attr_reader :workspaces

    private

    def load_from(filename)
      YAML.load_file(filename)
    end

    def default_config_file
      File.expand_path('~/.futon/default.yml')
    end

    def setup_workspaces(options)
      msg = 'expected valid config, got %s'
      raise Error::NoWorkspaces, format(msg, options.inspect) unless options

      workspaces = options.fetch(:workspaces)
      workspaces.map do |name, workspace_options|
        Workspace.new(workspace_options.merge(name: name))
      end

    rescue KeyError => e
      raise Error::NoWorkspaces, e.message
    end
  end
end
