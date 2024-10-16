class RegistrationError < StandardError
  class Unauthorized < self; end
end
