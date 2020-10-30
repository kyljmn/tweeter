class UserController < ApplicationController
  def index
    @users = User.all
    @pager = PagesService.new('user_index', @users, params.fetch(:page, 1).to_i)
  end

  def show
    @twit = Twit.new(twit_params)
    @user = User.find(params[:id])
    @pager = PagesService.new('post', @user, params.fetch(:page, 1).to_i)
  end

  private
    def twit_params
      return nil unless !params[:twit].nil?
      params.fetch(:twit, nil).permit(:body)
    end
end
