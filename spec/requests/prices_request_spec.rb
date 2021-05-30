require 'rails_helper'

RSpec.describe 'Prices', type: :request do
  let(:category) { create(:category) }
  let(:product) { create(:product, category_id: category.id) }
  let(:price) { create(:price, product_id: product.id, quantity: 2) }
  let!(:price1) { create(:price, product_id: product.id, buy_price: 100, sell_price: 200, quantity: 3) }
  let(:valid_params) { attributes_for :price, quantity: 2 }

  describe 'GET /edit' do
    it 'returns http success' do
      get "/products/#{price.product_id}/prices/#{price.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /update' do
    context 'with valid params' do
      it 'returns http redirect' do
        put "/products/#{price.product_id}/prices/#{price.id}", params: { price: valid_params.merge!(
          buy_price: 90, sell_price: 190
        ) }

        expect(response).to have_http_status(:redirect)
        expect(response).not_to render_template(:edit)
      end

      context 'when product exist with the same prices' do
        subject do
          put "/products/#{price.product_id}/prices/#{price.id}", params: { price: valid_params.merge!(
            buy_price: 100, sell_price: 200
          ) }
        end

        it 'adds updated price quantity to existing price' do
          expect { subject }.to change { price1.reload.quantity }.to(price.quantity + price1.quantity)
        end

        it 'deletes updated price' do
          subject
          expect(Price.find_by(id: price.id)).to be_nil
        end

        it { is_expected.not_to render_template(:edit) }

        it 'calls PriceUpdater service' do
          expect_any_instance_of(PriceUpdater).to receive(:call)
          subject
        end
      end
    end

    context 'with invalid params' do
      before do
        put "/products/#{price.product_id}/prices/#{price.id}", params: { price: valid_params.merge!(
          buy_price: nil, sell_price: '200'
        ) }
      end

      it 'returns edit template' do
        expect(response).not_to redirect_to(products_path)
        expect(response).to render_template(:edit)
      end

      it { expect(flash[:warning]).to be_present }
    end
  end

  describe 'DELETE /destroy' do
    subject { delete "/products/#{price.product_id}/prices/#{price.id}" }

    it 'redirect to products_path' do
      subject
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(products_path)
    end
  end
end
