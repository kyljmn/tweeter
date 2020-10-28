class FollowController < ApplicationController
  before_action :authenticate_user!
  before_action :user_from_params

  def following_index
    @follows = @user.followings
  end

  def follower_index
    @follows = @user.followers
  end

  def create
    Follow.build(follower: current_user.id, following: @following.id)
    byebug
    redirect_to user_twits_path
  end

  def destroy
    @follow = Follow.find_by("follower = ? AND following = ?", current_user.id, @following.id)
    byebug
  end

  private
    def user_from_params
      @following = User.find(params[:id])
    end
end
