require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  render_views
  let!(:category) { create(:category) }
  let(:valid_params) { attributes_for :category }

  describe 'GET#index' do
    before { get :index }

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:categories)).to eq([category]) }
    it { expect(response).to render_template('index') }
  end

  describe 'GET#new' do
    before { get :new }

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:category)).to be_a_new(Category) }
  end

  describe 'POST#create' do
    context 'with valid params' do
      subject { post :create, params: { category: valid_params } }

      it { expect { subject }.to change(Category, :count).by(1) }

      it 'redirects on categories index' do
        subject
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid params' do
      subject { post :create, params: { category: { title: '', description: 'Test description' } } }

      it { expect { subject }.to change(Category, :count).by(0) }
    end
  end

  describe 'GET#edit' do
    before { get :edit, params: { id: category.id } }

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:category)).to eq(category) }
  end

  describe 'PUT#update' do
    context 'with valid params' do
      before do
        put :update,
            params: { id: category.id, category: { title: 'Test title', description: 'Test description' } }
      end

      it { expect(assigns(:category)).to eq(category) }
      it { is_expected.to respond_with :redirect }
      it { expect(response).to redirect_to(categories_path) }
    end

    context 'with invalid params' do
      it 'does not change category' do
        expect do
          put :update, params: { id: category.id, category: { title: '', description: 'Test description' } }
        end.not_to change(category, :title)
      end
    end
  end

  describe 'DELETE#destroy' do
    subject { delete :destroy, params: { id: category.id } }

    it { expect { subject }.to change(Category, :count).by(-1) }
    it { is_expected.to redirect_to(categories_path) }
    it { expect(response).to have_http_status(:success) }
  end
end
