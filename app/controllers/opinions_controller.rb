class OpinionsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def create
    @opinion = current_user.opinions.build(opinion_params)
    if @opinion.save
      flash[:success] = 'Opinion created!'
    else
      flash[:warning] = @opinion.errors.full_messages
    end
    redirect_back(fallback_location: users_path)
  end

  def destroy; end

  private

  def opinion_params
    params.require(:opinion).permit(:text)
  end
end