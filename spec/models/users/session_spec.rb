# frozen_string_literal: true

describe Users::Session, type: :model do
  it 'factory should be valid' do
    users_session = build :users_session

    expect(users_session).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
