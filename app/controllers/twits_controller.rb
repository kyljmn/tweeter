class TwitsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_from_params, only: %i[index show create destroy]
  before_action :twit_from_params, only: %i[show destroy retwit unretwit]
  before_action :reply_to_from_params, only: %i[new_reply create_reply]

  def show; end

  def create
    @twit = @user.twits.new(twit_params)
    if @twit.save
      # extract usernames from twit body
      # done after @twit.save so @twit has an id
      make_mention_hashtag(@twit)
      redirect_to root_path
    else
      redirect_to root_path, alert: @twit.errors.full_messages[0]
    end
  end

  def destroy
    @twit = Twit.find(params[:id])
    @twit.destroy
    redirect_to root_path
  end

  def retwit
    @retwit = Twit.create(body: @twit.body, user: current_user, retwit_id: @twit.id, owner_id: @twit.user.id)
    @retwit.save
    redirect_to root_path
  end

  def unretwit
    @retwit = Twit.find_by(twit: @twit, user: current_user)
    @retwit.destroy
    redirect_to root_path
  end

  def new_reply
    @twit = Twit.new
  end

  def create_reply
    @twit = Twit.create(body: twit_params["body"], reply_to: @reply_to, user: current_user)
    make_mention_hashtag(@twit)
    redirect_to user_twit_path(current_user, @twit, anchor: @twit.id.to_s)
  end

  private
    def user_from_params
      @user = User.find(params[:user_id])
    end

    def twit_from_params
      @twit = Twit.find(params[:id])
    end

    def twit_params
      params.require(:twit).permit(:body, images: [])
    end

    def reply_to_from_params
      @reply_to = Twit.find(params[:id])
    end

    def make_mention_hashtag(twit)
      MentionsService.mention_creator(twit)
      HashtagsService.hashtag_creator(twit)
    end
end
