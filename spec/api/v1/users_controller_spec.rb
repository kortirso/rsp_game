# frozen_string_literal: true

describe Api::V1::UsersController do
  describe 'POST#create' do
    context 'without params' do
      before { post '/api/v1/users.json', params: { user: {} } }

      it 'and returns status 422' do
        expect(response.status).to eq 422
      end

      it 'and contains error message' do
        expect(JSON.parse(response.body)['errors'].size).not_to eq 0
      end
    end

    context 'for invalid params' do
      before { post '/api/v1/users.json', params: { user: { username: 'username', password: '12345678' } } }

      it 'and returns status 422' do
        expect(response.status).to eq 422
      end

      it 'and contains error message' do
        expect(JSON.parse(response.body)['errors'].size).not_to eq 0
      end
    end

    context 'for valid params' do
      before {
        post '/api/v1/users.json', params: {
          user: { username: 'username', password: '1234qwerQWER', password_confirmation: '1234qwerQWER' }
        }
      }

      it 'returns status 201' do
        expect(response.status).to eq 201
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
