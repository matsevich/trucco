require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:product) { create(:product, category_id: category.id) }
  let(:category) { create(:category) }
  let(:valid_params) { attributes_for :product }
  let(:price_params) { attributes_for :price }

  describe 'GET /index' do
    it 'returns http success' do
      get '/products'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/products/#{product.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/products/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'when the same-name product already exist' do
      subject do
        post '/products', params: {
          product: {
            name: 'Item', category_id: category.id,
            prices_attributes: [{ buy_price: 100, sell_price: 120, quantity: 2 }]
          }
        }
      end

      let!(:product_1) { create(:product, name: 'Item', category_id: category.id) }

      context 'when creating a product which has the same prices as the existing product' do
        let!(:price) do
          create(:price, buy_price: 100, sell_price: 120, quantity: 2, product_id: product_1.id)
        end

        it 'adds updated price quantity to existing price' do
          expect { subject }.to change { price.reload.quantity }.by(2)
        end

        it 'not created new product item' do
          expect { subject }.to change(Product, :count).by(0)
        end

        it { is_expected.not_to render_template(:new) }

        it 'calls ExistingProductPriceUpdater#update_quantity' do
          expect_any_instance_of(ExistingProductPriceUpdater).to receive(:update_quantity)
          subject
        end

        it 'calls ProductPriceHandler service' do
          expect_any_instance_of(ProductPriceHandler).to receive(:call)
          subject
        end
      end

      context 'when creating a product with a different price that existing product' do
        let(:prices) { product_1.prices }

        it 'adds new price to existing product' do
          expect { subject }.to change(product_1.prices, :count).by(1)
        end

        it 'calls ExistingProductPriceUpdater#update_prices' do
          expect_any_instance_of(ExistingProductPriceUpdater).to receive(:update_prices)
          subject
        end

        it 'not created new product item' do
          expect { subject }.to change(Product, :count).by(0)
        end

        it { is_expected.to redirect_to(products_path) }
      end

      context 'with invalid params' do
        it 'renders :new template with warning message' do
          post '/products', params: { product: { name: 'Item', category_id: '',
                                                 prices_attributes: [price_params.merge!(buy_price: 'x')] } }

          expect(response).to render_template(:new)
          expect(flash[:warning]).to be_present
        end
      end
    end

    context 'with valid params' do
      subject do
        post '/products', params: {
          product: {
            name: 'Item', category_id: category.id,
            prices_attributes: [price_params]
          }
        }
      end

      it 'returns http redirect' do
        subject
        expect(response).to have_http_status(:redirect)
      end

      it { expect { subject }.to change(Product, :count).by(1) }
    end

    context 'with invalid params' do
      it 'renders template with warning message' do
        post '/products', params: { product: {
          name: '', category_id: category.id, prices_attributes: [price_params]
        } }
        expect(response).to render_template(:new)
        expect(flash[:warning]).to be_present
      end
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/products/#{product.id}/edit"
      expect(response).to render_template(:edit)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /update' do
    context 'with valid params' do
      it 'returns http redirect' do
        put "/products/#{product.id}", params: { product: valid_params.merge!(
          name: 'Item'
        ) }
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'with invalid params' do
      it 'renders template with warning message' do
        put "/products/#{product.id}", params: { product: valid_params.merge!(
          name: ''
        ) }
        expect(response).to render_template(:edit)
        expect(flash[:warning]).to be_present
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'redirects to all products' do
      delete "/products/#{product.id}"
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(products_path)
    end
  end
end
