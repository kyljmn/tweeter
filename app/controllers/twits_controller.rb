class TwitsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_from_params, only: %i[ index create destroy edit update ]
  def index
    @twits = @user.twits
  end

  def new
    @twit = Twit.new
  end

  def create
    @twit = @user.twits.build(twit_params)
    byebug
  end

  def destroy
  end

  private
    def user_from_params
      @user = User.find(params[:user_id])
    end

    def twit_params
      params.require(:twit).permit(:body)
    end
end
