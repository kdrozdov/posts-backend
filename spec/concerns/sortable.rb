require 'rails_helper'

shared_examples_for 'sortable' do
  let(:model_name) { described_class.to_s.underscore.to_sym }

  describe '#apply_sort' do
    let!(:model1) { create(model_name, created_at: 2.hours.ago) }
    let!(:model2) { create(model_name, created_at: 1.hour.ago) }

    it 'returns sorted records' do
      array = described_class.apply_sort('created_at', 'desc').to_a
      expect(array).to eq([model2, model1])
    end

    it 'returns all records if invalid field' do
      array = described_class.apply_sort('invalid', 'desc')
      expect(array).to eq(described_class.all)
    end

    it 'returns all records if invalid direction' do
      array = described_class.apply_sort('created_at', 'qwer')
      expect(array).to eq(described_class.all)
    end
  end
end
