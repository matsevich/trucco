require 'rails_helper'

RSpec.describe Admin, type: :model do
  context 'when valid Factory' do
    it 'has a valid factory' do
      expect(create(:admin)).to be_valid
    end
  end

  describe '#full_name' do
    let(:admin) { create(:admin) }

    it 'returns valid admin first_name + last_name' do
      expect(admin.full_name).to eq("#{admin.first_name} #{admin.last_name}")
    end
  end
end
