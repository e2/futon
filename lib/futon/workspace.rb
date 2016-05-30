require 'futon/workspace/provider/git'

module Futon
  class Workspace
    class Error < RuntimeError
      class MissingSource < Error
      end
    end

    def initialize(options)
      source = options.fetch(:source) { raise Error::MissingSource }
      @provider = Provider::Git.new(source)
      @directory = File.expand_path(options.fetch(:directory))
    end

    def setup
      provider.provide(directory)
    end

    private

    attr_reader :directory

    attr_reader :provider
  end
end
