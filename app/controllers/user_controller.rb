class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :user_from_params, only: %i[show edit update]
  before_action :auth_guard, only: %i[edit update]

  def index
    @users = User.all
    @pager = PagesService.new("user_index", @users, params.fetch(:page, 1).to_i)
  end

  def show
    @twit = Twit.new(twit_params)
    @pager = PagesService.new("post", @user, params.fetch(:page, 1).to_i)

    @tweets = Twit.where(user: @user).paginate(page: params[:page], per_page: 10).order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json {
        render json: { entries: render_to_string(partial: "twits/render_table", formats: [:html]), pagination: view_context.will_paginate(@tweets)}
      }
    end
  end

  private

    def user_from_params
      @user = User.find(params[:id])
    end

    def auth_guard
      redirect_to root_path if @user.id != current_user.id
    end

    def user_params
      params.require(:user).permit(:profile_picture)
    end

    def twit_params
      return nil if params[:twit].nil?

      params.fetch(:twit, nil).permit(:body)
    end
end
