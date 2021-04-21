class User < ApplicationRecord
  has_many :opinions, foreign_key: 'author_id'
  has_one_attached :photo
  has_one_attached :coverimage
  has_many :active_relationships, class_name: 'Following', foreign_key: 'follower_id'
  has_many :following, through: :active_relationships, source: :followed

  validates :username, presence: true, length: { minimum: 2 }
  validates :fullname, presence: true, length: { minimum: 3 }
  validates :photo, content_type: { in: %w[image/jpeg image/gif image/png], message: 'must be a valid image format' },
                    size: { less_than: 2.megabytes, message: 'should be less than 2MB' }
  validates :coverimage, content_type: { in: %w[image/jpeg image/gif image/png],
                                         message: 'must be a valid image format' },
                         size: { less_than: 4.megabytes, message: 'should be less than 4MB' }

  # Resize uploaded images for display
  def profile_photo
    photo.variant(resize_to_limit: [100, 100])
  end

  def timeline
    Opinion.where('author_id = ?', id)
  end

  # Follow another user
  def follow(another_user)
    following << another_user
  end

  # Unfollow a user
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Check if current user is following a user
  def following?(user)
    following.include?(user)
  end
end
