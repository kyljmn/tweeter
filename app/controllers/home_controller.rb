class HomeController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to new_user_session_path 
    else
      @user = User.find(current_user.id)
      relevant_users = @user.following_ids + [@user.id]
      @twits = Twit.where(user: relevant_users).reverse()
    end
  end
end
