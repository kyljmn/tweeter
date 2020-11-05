class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :user_from_params, only: %i[show edit update]
  before_action :auth_guard, only: %i[edit update]
  
  def index
    @users = User.all
    @pager = PagesService.new('user_index', @users, params.fetch(:page, 1).to_i)
  end

  def show
    @twit = Twit.new(twit_params)
    @pager = PagesService.new('post', @user, params.fetch(:page, 1).to_i)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      redirect_to edit_user_path(@user)
    end
  end

  private
    def user_from_params
      @user = User.find(params[:id])
    end

    def auth_guard
      if @user.id != current_user.id
        redirect_to root_path
      end
    end

    def user_params
      params.require(:user).permit(:profile_picture)
    end

    def twit_params
      return nil unless !params[:twit].nil?
      params.fetch(:twit, nil).permit(:body)
    end
end
