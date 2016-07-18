require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  subject { JSON.parse(response.body).fetch('data') }

  describe 'GET #index' do
    let!(:users) { create_list(:user, 3) }
    before { do_request }

    it 'returns 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'returns list of users' do
      expect(subject.length).to eq(users.length)
    end

    def do_request(options = {})
      get '/api/users', as: :json, params: options
    end
  end
end
