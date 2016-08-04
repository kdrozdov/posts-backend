require 'rails_helper'

shared_examples_for 'posts searchable' do
  let(:model_name) { described_class.to_s.underscore.to_sym }

  describe '#search' do
    let!(:model1) { create(model_name, title: 'example') }
    let!(:model2) { create(model_name, title: 'qwer1') }

    it 'returns search result' do
      array = described_class.search('ex').to_a
      expect(array).to eq([model1])
    end
  end
end
