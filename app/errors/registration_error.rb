# frozen_string_literal: true

class RegistrationError < StandardError
  class Unauthorized < self
    def initialize
      super('You are not authorized to perform this action')
    end
  end
end
