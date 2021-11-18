class FollowingsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to request.referrer || users_url
  end

  def destroy
    user = Following.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to request.referrer || users_url
  end
end
