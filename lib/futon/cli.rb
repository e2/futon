require 'futon/configuration'
require 'futon/workspace'

module Futon
  class Cli
    def initialize(_argv)
      @config = Configuration.new
    end

    def execute!
      @config.workspaces.map(&:setup)
    end
  end
end
