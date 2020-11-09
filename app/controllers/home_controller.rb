class HomeController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @twit = Twit.new
      @user = User.find(current_user.id)
      relevant_users = @user.following_ids + [@user.id]
      @pager = PagesService.new("post", relevant_users, params.fetch(:page, 1).to_i)

      @tweets = Twit.where(user: relevant_users).paginate(page: params[:page], per_page: 10).order(created_at: :desc)

      respond_to do |format|
        format.html
        format.json do
          render json: { entries: render_to_string(partial: "twits/render_table", formats: [:html]), pagination: view_context.will_paginate(@tweets) }
        end
      end
    end
  end
end
