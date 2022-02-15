# frozen_string_literal: true

describe Api::V1::Users::TokenController do
  describe 'POST#create' do
    context 'without params' do
      before { post '/api/v1/users/token.json', params: {} }

      it 'returns status 401' do
        expect(response.status).to eq 401
      end

      it 'and contains error message' do
        expect(JSON.parse(response.body)).to eq('errors' => 'No auth strategy found')
      end
    end

    context 'for database params' do
      context 'for invalid params' do
        before { post '/api/v1/users/token.json', params: { username: 'username', password: '1234567890' } }

        it 'returns status 401' do
          expect(response.status).to eq 401
        end

        it 'and contains error message' do
          expect(JSON.parse(response.body)).to eq('errors' => 'Authorization error')
        end
      end

      context 'for valid params' do
        let!(:user) { create :user }

        before { post '/api/v1/users/token.json', params: { username: user.username, password: user.password } }

        it 'returns status 200' do
          expect(response.status).to eq 200
        end

        it 'and contains token' do
          expect(response.body).to have_json_path('token')
        end

        %w[password password_confirmation].each do |attr|
          it "and does not contain user #{attr}" do
            expect(response.body).not_to have_json_path(attr)
          end
        end
      end
    end
  end
end
