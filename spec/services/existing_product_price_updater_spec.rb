require 'rails_helper'

RSpec.describe ExistingProductPriceUpdater do
  subject { described_class.new(product, existing_product, product_price) }

  let(:product) { create(:product, category_id: category.id) }
  let(:product_price) { create(:price, product_id: product.id, buy_price_cents: 100, sell_price_cents: 120) }
  let(:existing_product_price) do
    create(:price, product_id: existing_product.id, buy_price_cents: 100, sell_price_cents: 120)
  end
  let(:category) { create(:category) }
  let(:existing_product) { create(:product, category_id: category.id) }

  describe '#update_quantity' do
    it 'updates existing product price quantity' do
      expect { subject.update_quantity }.to change { existing_product_price.reload.quantity }
        .from(existing_product_price.quantity).to(product_price.quantity + existing_product_price.quantity)
    end
  end

  describe '#update_prices' do
    it 'adds new product price to existing product prices' do
      expect { subject.update_prices }.to change(existing_product.reload.prices, :count).by(1)
    end
  end
end
