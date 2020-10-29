class HomeController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to new_user_session_path 
    else
      @twit = Twit.new()
      @user = User.find(current_user.id)
      relevant_users = @user.following_ids + [@user.id]
      @twits = Twit.where(user: relevant_users).to_a
      @retwits = Retwit.where(retwiter: relevant_users).to_a
      @all = (@twits + @retwits).sort_by(&:created_at).reverse
    end
  end
end
