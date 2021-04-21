module UsersHelper
  def avatar_for(user)
    if user.photo.attached?
      image_tag(user.profile_photo, class: 'profile-dp')
    else
      image_tag('default-avatar.png', alt: user.username, class: 'avatar')
    end
  end

  def cover_image_for(user)
    if user.coverimage.attached?
      image_tag(user.coverimage)
    else
      image_tag('ci-unsplash.jpg')
    end
  end

  def tweets(user)
    'Tweet'.pluralize(user.opinions.count)
  end

  def action(user)
    return if current_user?(user)

    if current_user.following?(user)
      render 'unfollow', unfollow: user
    else
      render 'follow', follow: user
    end
  end
end
