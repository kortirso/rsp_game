# frozen_string_literal: true

describe User, type: :model do
  it 'factory should be valid' do
    user = build :user

    expect(user).to be_valid
  end
end
