class TwitsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_from_params, only: %i[ index show create destroy ]
  before_action :twit_from_params, only: %i[ show destroy retwit unretwit ]

  def show
    render "twits/show", locals: { twit: @twit }
  end

  def create
    @twit = @user.twits.new(twit_params)
    if @twit.save
      # extract usernames from twit body
      # done after @twit.save so @twit has an id
      mention_creator
      redirect_to user_path(@user)
    else
      redirect_to user_path(@user, twit: twit_params), alert: @twit.errors.full_messages[0]
    end
  end

  def destroy
    @twit = Twit.find(params[:id])
    @twit.destroy
    redirect_to user_path(@user)
  end

  def retwit
    @retwit = Twit.create(body: @twit.body, user: current_user, retwit_id: @twit.id, owner_id: @twit.user.id)
    @retwit.save
    redirect_to user_path(current_user)
  end

  def unretwit
    @retwit = Twit.find_by(twit: @twit, user: current_user)
    @retwit.destroy
    redirect_to user_path(current_user)
  end

  private
    def user_from_params
      @user = User.find(params[:user_id])
    end

    def twit_from_params
      @twit = Twit.find(params[:id])
    end

    def twit_params
      params.require(:twit).permit(:body)
    end

    def mention_creator
      mentioned_usernames = twit_params["body"].scan(/@(\w+)/).flatten.uniq
      if !mentioned_usernames.empty?
        mentioned_usernames.each do |username|
          mentioned_user = User.find_by(username: username)
          @mention = Mention.create(user: mentioned_user, twit: @twit)
        end
      end
    end
end
