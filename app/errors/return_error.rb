# frozen_string_literal: true

class ReturnError < StandardError
  class Unauthorized < self; end
  class DeviceNotFound < self; end
  class DeviceAlreadyReturned < self; end
end
