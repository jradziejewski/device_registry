# frozen_string_literal: true

class RegistrationError < StandardError
  class Unauthorized < self; end
end
