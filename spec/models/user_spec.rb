require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:posts).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }

  context 'password changed' do
    before { allow(subject).to receive(:password_changed?).and_return(true) }
    it { should validate_length_of(:password).is_at_least(3) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
  end

  context 'password not changed' do
    before { allow(subject).to receive(:password_changed?).and_return(false) }
    it { should_not validate_length_of(:password).is_at_least(3) }
    it { should_not validate_presence_of(:password_confirmation) }
  end
end
