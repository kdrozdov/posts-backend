require 'rails_helper'

RSpec.describe 'AuthTokens API', type: :request do
  subject { JSON.parse(response.body).fetch('jwt') }

  describe 'POST #create' do
    let(:user) { create(:user, password: '123456') }
    let(:auth_params) do
      { auth: { phone: user.phone, password: user.password } }
    end

    it 'returns 201 status code' do
      do_request(auth_params)
      expect(response.status).to eq(201)
    end

    it 'returns auth token' do
      do_request(auth_params)
      decoded_token = Knock::AuthToken.new(token: subject)
      expect(decoded_token.payload['sub']).to eq(user.id)
    end

    context 'invalid password' do
      let(:auth_params) do
        { auth: { phone: user.phone, password: '1134566' } }
      end

      it 'returns 404 status code' do
        do_request(auth_params)
        expect(response.status).to eq(404)
      end
    end

    def do_request(options = {})
      post '/api/auth_tokens', as: :json, params: options
    end
  end
end
