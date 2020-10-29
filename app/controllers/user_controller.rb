class UserController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @twit = Twit.new()
    @user = User.find(params[:id])
    @twits = Twit.where(user: @user).to_a
    @retwits = Retwit.where(retwiter: @user).to_a
    @all = (@twits + @retwits).sort_by(&:created_at).reverse
  end
end
