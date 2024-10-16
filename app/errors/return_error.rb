class ReturnError < StandardError
  class Unauthorized < self; end
end
