class RegistrationError < StandardError
  class Unauthorized < self; end
end

class AssigningError < StandardError
  class AlreadyUsedOnOtherUser < self; end
  class AlreadyUsedOnUser < self; end
end