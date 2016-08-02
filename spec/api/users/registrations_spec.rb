require 'rails_helper'

RSpec.describe 'Registrations API', type: :request do
  subject { JSON.parse(response.body).fetch('jwt') }

  describe 'POST #create' do
    let(:user_params) do
      { user: attributes_for(:user) }
    end

    it 'returns 201 status code' do
      do_request(user_params)
      expect(response.status).to eq(201)
    end

    it 'changes user count' do
      expect { do_request(user_params) }.to change(User, :count).by(1)
    end

    it 'returns auth token' do
      do_request(user_params)
      decoded_token = Knock::AuthToken.new(token: subject)
      expect(decoded_token.payload['sub']).to eq(User.last.id)
      expect(decoded_token.payload['name']).to eq(User.last.name)
    end

    def do_request(options = {})
      post '/api/registrations', as: :json, params: options
    end
  end
end
