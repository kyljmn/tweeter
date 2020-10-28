class HomeController < ApplicationController
  def index
    @user = User.find(current_user.id)
    redirect_to new_user_session_path if !user_signed_in?
  end
end
