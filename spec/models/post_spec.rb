require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }

  it_behaves_like 'sortable'
  it_behaves_like 'posts searchable'
end
