module Futon
  class Os
    def self.system(*args)
      Kernel.system(*args)
    end
  end
end
