class PagesService
  POST_PER_PAGE = 10.0
  attr_accessor :page

  def initialize(type, query, page)
    @query = query
    @page = page
    @type = type
  end

  def fetch_items
    case @type
    when "post"
      Twit.where(user: @query).order(created_at: :desc).offset((@page - 1) * POST_PER_PAGE).limit(POST_PER_PAGE)
    when "following"
      @query.followings.order(created_at: :desc).offset((@page - 1) * POST_PER_PAGE).limit(POST_PER_PAGE)
    when "followers"
      @query.followers.order(created_at: :desc).offset((@page - 1) * POST_PER_PAGE).limit(POST_PER_PAGE)
    when "user_index"
      @query.order(created_at: :desc).offset((@page - 1) * POST_PER_PAGE).limit(POST_PER_PAGE)
    when "notification"
      Notification.where(user: @query).order(is_read: :asc).order(created_at: :desc).offset((@page - 1) * POST_PER_PAGE).limit(POST_PER_PAGE)
    when "hashtag_index"
      @query.twits.order(created_at: :desc).offset((@page - 1) * POST_PER_PAGE).limit(POST_PER_PAGE)
    end
  end

  def count_pages
    case @type
    when "post"
      count(Twit.where(user: @query).size)
    when "following"
      count(@query.followings.size)
    when "followers"
      count(@query.followers.size)
    when "user_index"
      count(@query.size)
    when "notification"
      count(Notification.where(user: @query).size)
    when "hashtag_index"
      count(@query.twits.size)
    end
  end

  private

    def count(records)
      (records / POST_PER_PAGE).ceil
    end
end
