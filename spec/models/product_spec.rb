require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price_cents) }
    it { is_expected.to validate_numericality_of(:price_cents) }
    it { is_expected.to monetize(:price) }
    it { is_expected.to monetize(:price).with_currency(:uah) }
    it { is_expected.to belong_to(:category) }
  end
end
