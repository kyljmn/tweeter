class FollowController < ApplicationController
  before_action :authenticate_user!
  before_action :user_from_params

  def following_index
    @follows = @user.followings
    render "follows", locals: { action: "Following", user: @user }
  end

  def follower_index
    @follows = @user.followers
    render "follows", locals: { action: "Followers", user: @user  }
  end

  def follow
    @follow = Follow.create({:follower => current_user, :following => @user})
    redirect_to user_path(@user)
  end

  def unfollow
    @follow = Follow.find_by("follower_id = ? AND following_id = ?", current_user.id, @user.id)
    @follow.destroy
    redirect_to user_path(@user)
  end

  private
    def user_from_params
      @user = User.find(params[:id])
    end
end
