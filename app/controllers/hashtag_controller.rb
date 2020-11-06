class HashtagController < ApplicationController
  before_action :hashtag_from_params
  def show
    @pager = PagesService.new("hashtag_index", @hashtag, params.fetch(:page, 1).to_i)
  end

  private

    def hashtag_from_params
      @hashtag = Hashtag.find(params[:id])
    end
end
