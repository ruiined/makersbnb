# frozen_string_literal: true

# User class
class User
  def initialize(id:, username:, password:, email:)
    @id = id
    @username = username
    @password = password
    @email = email
  end
end
