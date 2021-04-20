class Opinion < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  default_scope -> { order(created_at: :desc) }
  validates :text, presence: true, length: { maximum: 140 }
end
