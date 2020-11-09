class HashtagController < ApplicationController
  before_action :hashtag_from_params
  def show
    @pager = PagesService.new("hashtag_index", @hashtag, params.fetch(:page, 1).to_i)
    @hashtags = Hashtag.all

    @tweets = @hashtag.twits.paginate(page: params[:page], per_page: 10).order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json do
        render json: { entries: render_to_string(partial: "twits/render_table", formats: [:html]), pagination: view_context.will_paginate(@tweets) }
      end
    end
  end

  private

    def hashtag_from_params
      @hashtag = Hashtag.find(params[:id])
    end
end
