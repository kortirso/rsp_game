# frozen_string_literal: true

describe Api::V1::StatusController do
  describe 'GET#show' do
    before { get '/api/v1/status.json' }

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'and contains message' do
      expect(JSON.parse(response.body)).to eq('message' => 'Server is on')
    end
  end
end
