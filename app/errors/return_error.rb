class ReturnError < StandardError
  class Unauthorized < self; end
  class DeviceNotFound < self; end
  class DeviceAlreadyReturned < self; end
end
