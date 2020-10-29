class TwitsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_from_params, only: %i[ index create destroy ]
  before_action :twit_from_params, only: %i[ destroy retwit unretwit ]

  def create
    @twit = @user.twits.new(twit_params)
    if @twit.save
      # extract usernames from twit body
      # done after @twit.save so @twit has an id
      mention_creator
      redirect_to user_path(@user)
    else
      @all = TwitsService.get_twits_retwits(@user)
      render 'user/show'
    end
  end

  def destroy
    @twit = Twit.find(params[:id])
    @twit.destroy
    redirect_to user_path(@user)
  end

  def retwit
    @retwit = Retwit.create({:twit => @twit, :retwiter => current_user})
    redirect_to user_path(current_user)
  end

  def unretwit
    @retwit = Retwit.find_by(twit: params[:id], retwiter: current_user)
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
