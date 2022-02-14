# frozen_string_literal: true

class User < ApplicationRecord
  include ActiveModel::SecurePassword
  include Uuidable

  has_secure_password
end
