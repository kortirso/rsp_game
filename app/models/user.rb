# frozen_string_literal: true

class User < ApplicationRecord
  include ActiveModel::SecurePassword
  include Uuidable

  has_secure_password

  has_many :sessions, class_name: 'Users::Session', foreign_key: :user_id, dependent: :destroy
end
