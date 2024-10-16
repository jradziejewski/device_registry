class RegistrationError < StandardError
  class Unauthorized < self; end
  class AlreadyUsedOnUser < self; end
  class AlreadyUsedOnOtherUser < self; end
end