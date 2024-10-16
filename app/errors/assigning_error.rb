class AssigningError < StandardError
  class AlreadyUsedOnOtherUser < self; end
  class AlreadyUsedOnUser < self; end
end
