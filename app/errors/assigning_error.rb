# frozen_string_literal: true

class AssigningError < StandardError
  class AlreadyUsedOnOtherUser < self; end
  class AlreadyUsedOnUser < self; end
end
