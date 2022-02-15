# frozen_string_literal: true

module Users
  class Session < ApplicationRecord
    self.table_name = :users_sessions

    include Uuidable

    belongs_to :user
  end
end
