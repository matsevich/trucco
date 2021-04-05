require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:product) { create(:product, category_id: category.id) }
  let(:category) { create(:category) }
  let(:valid_params) { attributes_for :product }

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
    context 'with valid params' do
      subject { post '/products', params: { product: valid_params.merge!(category_id: category.id) } }

      xit 'returns http redirect' do
        subject
        expect(response).to have_http_status(:redirect)
      end

      xit { expect { subject }.to change(Product, :count).by(1) }
    end

    context 'with invalid params' do
      it 'returns current turbo-frame' do
        post '/products', params: { product: valid_params.merge!(
          category_id: category.id, name: '', price: '100'
        ) }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/products/#{product.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /update' do
    context 'with valid params' do
      it 'returns http redirect' do
        put "/products/#{product.id}", params: { product: valid_params.merge!(
          name: 'Item', price: 100
        ) }
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'with invalid params' do
      it 'returns current turbo-frame' do
        put "/products/#{product.id}", params: { product: valid_params.merge!(
          name: '', price: '100'
        ) }
        expect(response).to have_http_status(:success)
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
