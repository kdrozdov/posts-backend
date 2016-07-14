require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Posts' do
  subject { JSON.parse(response_body).fetch('data') }

  get 'api/posts' do
    let!(:posts) { create_list(:post, 3) }

    example_request 'Listing posts' do
      expect(response_status).to eq(200)
      expect(subject.length).to eq(posts.length)
    end
  end

  post 'api/posts' do
    let(:post_params) do
      { post: attributes_for(:post) }
    end

    example 'Create post' do
      expect{ do_request(post_params) }.to change(Post, :count).by(1)
      expect(response_status).to eq(201)
      expect(subject['attributes']['title']).to eq(post_params[:post][:title])
    end
  end

  get 'api/posts/:id' do
    let(:post) { create(:post) }
    let!(:id) { post.id }

    example_request 'Show post' do
      expect(response_status).to eq(200)
      expect(subject['id'].to_i).to eq(post.id)
      expect(subject['attributes']['title']).to eq(post.title)
    end
  end

  put 'api/posts/:id' do
    let(:post) { create(:post, title: 'Old title') }
    let(:title) { 'New title' }
    let!(:id) { post.id }

    parameter :id

    example 'Update post' do
      do_request({ post: { title: title }})
      expect(response_status).to eq(200)
      expect(subject['attributes']['title']).to eq(title)
    end
  end

  delete 'api/posts/:id' do
    let(:post) { create(:post) }
    let!(:id) { post.id }

    example 'Destroy post' do
      expect{ do_request() }.to change(Post, :count).by(-1)
      expect(response_status).to eq(204)
    end
  end
end
