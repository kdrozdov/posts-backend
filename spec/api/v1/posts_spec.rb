require 'rails_helper'

RSpec.describe 'V1::Posts API', type: :request do
  let(:user) { create(:user) }
  let(:auth_header) { { 'HTTP_AUTHORIZATION' => "Bearer #{user.to_token}" } }
  subject { JSON.parse(response.body).fetch('data') }

  describe 'GET #index' do
    let!(:posts) { create_list(:post, 3) }

    it 'returns 200 status code' do
      do_request
      expect(response.status).to eq(200)
    end

    it 'returns list of posts' do
      do_request
      expect(subject.length).to eq(posts.length)
    end

    context 'with search param' do
      let!(:post) { create(:post, title: '111222333') }
      let(:options) { { q: '111' } }

      it 'returns search result' do
        do_request(options)
        expect(subject.length).to eq(1)
        expect(subject[0]['id']).to eq(post.id.to_s)
      end
    end

    context 'with sort params' do
      let(:options) { { sort_by: :created_at, sort_direction: :desc } }

      it 'returns sorted result' do
        do_request(options)
        expect(subject[0]['id']).to eq(posts.last.id.to_s)
      end
    end

    context 'with page param' do
      let(:options) { { page: 2, per: 2 } }

      it 'returns paginated result' do
        do_request(options)
        expect(subject.length).to eq(1)
      end
    end

    def do_request(options = {})
      get api_v1_posts_path, params: options
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
      expect { do_request(post_params) }.to change(Post, :count).by(1)
    end

    it 'returns post' do
      do_request(post_params)
      expect(subject['attributes']['title']).to eq(post_params[:post][:title])
      image_url = Post.last.image.small.url
      expect(subject['attributes']['image']['small']).to eq(image_url)
    end

    it 'bind post with current user' do
      do_request(post_params)
      expect(subject['attributes']['username']).to eq(user.name)
    end

    def do_request(options = {})
      post api_v1_posts_path, params: options, headers: auth_header
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

    def do_request(options = {})
      get api_v1_post_path(post), as: :json, params: options
    end
  end

  describe 'PUT #update' do
    let!(:post) { create(:post, title: 'Old title') }
    let(:title) { 'New title' }
    let(:post_params) do
      { post: { title: title } }
    end
    before { do_request(post_params) }

    it 'returns 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'update post' do
      expect(subject['attributes']['title']).to eq(title)
    end

    def do_request(options = {})
      put api_v1_post_path(post.id), as: :json, params: options,
                                     headers: auth_header
    end
  end

  describe 'DELETE #destroy' do
    let!(:post) { create(:post) }

    it 'returns 204 status code' do
      do_request
      expect(response.status).to eq(204)
    end

    it 'destroy post' do
      expect { do_request }.to change(Post, :count).by(-1)
    end

    def do_request(options = {})
      delete api_v1_post_path(post.id), as: :json, params: options,
                                        headers: auth_header
    end
  end
end
