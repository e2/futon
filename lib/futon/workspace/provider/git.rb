require 'futon/os'
require 'futon/workspace/provider'

module Futon
  class Workspace
    class Provider
      class Git < Provider
        class Error < Provider::Error
          class CloneFailed < Error
          end
        end

        def initialize(options)
          @url = options.fetch(:url)
        end

        def provide(directory)
          args = %W(git clone #{url} #{directory})
          result = Os.system(*args)
          return if result == true

          info = result.nil? ? '(exec failed)' : $CHILD_STATUS.to_s
          msg = "command failed [%s]: '%s'"
          raise Error::CloneFailed, format(msg, info, args.join(' '))
        end

        private

        attr_reader :url
      end
    end
  end
end
