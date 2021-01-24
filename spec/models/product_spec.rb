require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'alidations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
