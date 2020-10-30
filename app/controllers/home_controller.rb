class HomeController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to new_user_session_path 
    else
      @twit = Twit.new()
      @user = User.find(current_user.id)
      relevant_users = @user.following_ids + [@user.id]
      @pager = PagesService.new('post', relevant_users, params.fetch(:page, 1).to_i)
    end
  end
end
