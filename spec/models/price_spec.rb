require 'rails_helper'

RSpec.describe Price, type: :model do
  describe 'validations' do
    it { is_expected.to monetize(:buy_price) }
    it { is_expected.to monetize(:sell_price) }
    it { is_expected.to monetize(:buy_price).with_currency(:uah) }
    it { is_expected.to monetize(:sell_price).with_currency(:uah) }
    it { is_expected.to validate_presence_of(:buy_price_cents) }
    it { is_expected.to validate_presence_of(:sell_price_cents) }
    it { is_expected.to belong_to(:product) }
  end
end
