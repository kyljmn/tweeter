class HomeController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to new_user_session_path 
    else
      @twit = Twit.new()
      @user = User.find(current_user.id)
      relevant_users = @user.following_ids + [@user.id]
      @all = TwitsService.get_twits_retwits(relevant_users)
    end
  end
end
