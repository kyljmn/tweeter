class FollowController < ApplicationController
  before_action :authenticate_user!
  before_action :user_from_params

  def following_index
    @pager = PagesService.new("following", @user, params.fetch(:page, 1).to_i)
    render "follows", locals: { action: "Following" }
  end

  def follower_index
    @pager = PagesService.new("followers", @user, params.fetch(:page, 1).to_i)
    render "follows", locals: { action: "Followers" }
  end

  def follow
    @follow = Follow.create({:follower => current_user, :following => @user})
    redirect_to root_path
  end

  def unfollow
    @follow = Follow.find_by("follower_id = ? AND following_id = ?", current_user.id, @user.id)
    @follow.destroy
    redirect_to root_path
  end

  private

    def user_from_params
      @user = User.find(params[:id])
    end
end
