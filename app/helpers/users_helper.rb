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
end
