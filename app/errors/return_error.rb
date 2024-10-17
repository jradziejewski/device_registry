# frozen_string_literal: true

class ReturnError < StandardError
  class Unauthorized < self
    def initialize
      super('You are not authorized to perform this action')
    end
  end
  class DeviceNotFound < self 
    def initialize
      super('Device not found')
    end
  end
  class DeviceAlreadyReturned < self 
    def initialize
      super('Device is already returned')
    end
  end
end
