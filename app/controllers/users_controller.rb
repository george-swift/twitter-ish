class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index show edit update]
  before_action :right_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to Twitter-ish'
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.all
    @opinion = current_user.opinions.build
    @opinions = current_user.timeline
  end

  def show
    @user = User.find(params[:id])
    @opinions = @user.opinions.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Twitter-ish profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :username, :photo, :coverimage)
  end

  def right_user
    @user = User.find(params[:id])
    redirect_to current_user unless current_user?(@user)
  end
end
