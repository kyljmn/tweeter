class FollowController < ApplicationController
  before_action :authenticate_user!
  before_action :user_from_params

  def following_index
    @follows = @user.followings
  end

  def follower_index
    @follows = @user.followers
  end

  def follow
    @follow = Follow.create({:follower => current_user, :following => @following})
    byebug
    redirect_to user_twits_path
  end

  def unfollow
    @follow = Follow.find_by("follower_id = ? AND following_id = ?", current_user.id, @following.id)
    byebug
  end

  private
    def user_from_params
      @following = User.find(params[:id])
    end
end
