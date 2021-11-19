class OpinionsController < ApplicationController
  before_action :logged_in_user
  before_action :right_author, only: :destroy

  def create
    @opinion = current_user.opinions.build(opinion_params)
    if @opinion.save
      flash[:success] = 'Opinion created!'
    else
      flash[:warning] = @opinion.errors.full_messages
    end
    redirect_back(fallback_location: users_path)
  end

  def destroy
    @opinion.destroy
    flash[:success] = 'Opinion deleted'
    redirect_to request.referrer || users_url
  end

  private

  def opinion_params
    params.require(:opinion).permit(:text)
  end

  def right_author
    @opinion = current_user.opinions.find_by(id: params[:id])
    redirect_to users_url if @opinion.nil?
  end
end
