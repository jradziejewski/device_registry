# frozen_string_literal: true

class AssigningError < StandardError
  class AlreadyUsedOnOtherUser < self
    def initialize
      super('Device is already assigned to another user')
    end
  end

  class AlreadyUsedOnUser < self
    def initialize
      super('Device was previously assigned to the user')
    end
  end
end
