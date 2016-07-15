require 'rails_helper'

RSpec.describe 'Posts API', type: :request do
  subject { JSON.parse(response.body).fetch('data') }

  describe 'GET #index' do
    let!(:posts) { create_list(:post, 3) }
    before { do_request }

    it 'returns 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'returns list of posts' do
      expect(subject.length).to eq(posts.length)
    end

    def do_request(options={})
      get '/api/posts', as: :json, params: options
    end
  end

  describe 'POST #create' do
    let(:post_params) do
      { post: attributes_for(:post) }
    end

    it 'returns 201 status code' do
      do_request(post_params)
      expect(response.status).to eq(201)
    end

    it 'changes post count' do
      expect{ do_request(post_params) }.to change(Post, :count).by(1)
    end

    it 'returnes post' do
      do_request(post_params)
      expect(subject['attributes']['title']).to eq(post_params[:post][:title])
    end

    def do_request(options={})
      post '/api/posts', as: :json, params: options
    end
  end

  describe 'GET #show' do
    let!(:post) { create(:post) }
    before { do_request }

    it 'returns 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'returns post' do
      expect(subject['id'].to_i).to eq(post.id)
      expect(subject['attributes']['title']).to eq(post.title)
    end

    def do_request(options={})
      get "/api/posts/#{post.id}", as: :json, params: options
    end
  end

  describe 'PUT #update' do
    let!(:post) { create(:post, title: 'Old title') }
    let(:title) { 'New title' }
    let(:post_params) do
      { post: { title: title }}
    end
    before { do_request(post_params) }

    it 'returns 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'update post' do
      expect(subject['attributes']['title']).to eq(title)
    end

    def do_request(options={})
      put "/api/posts/#{post.id}", as: :json, params: options
    end
  end

  describe 'DELETE #destroy' do
    let!(:post) { create(:post) }

    it 'returns 204 status code' do
      do_request
      expect(response.status).to eq(204)
    end

    it 'destroy post' do
      expect{ do_request() }.to change(Post, :count).by(-1)
    end

    def do_request(options={})
      delete "/api/posts/#{post.id}", as: :json, params: options
    end
  end
end
