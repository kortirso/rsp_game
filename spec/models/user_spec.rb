# frozen_string_literal: true

describe User, type: :model do
  it 'factory should be valid' do
    user = build :user

    expect(user).to be_valid
  end

  describe 'associations' do
    it {
      is_expected.to have_many(:sessions).class_name('Users::Session').with_foreign_key(:user_id).dependent(:destroy)
    }
  end
end
