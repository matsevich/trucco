class Category < ApplicationRecord
  has_many :products, dependent: :nullify

  validates :title, presence: true, uniqueness: true, length: { maximum: 120 }

  after_create_commit { broadcast_prepend_to 'categories' }
  after_update_commit { broadcast_replace_to 'categories' }
  after_destroy_commit { broadcast_remove_to 'categories' }
end
