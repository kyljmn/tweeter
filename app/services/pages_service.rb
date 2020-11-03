class PagesService
  POST_PER_PAGE = 10.0
  attr_accessor :page
  def initialize(type, people, page)
    @people = people
    @page = page
    @type = type
  end
  
  def get_items
    if @type == 'post'
      return Twit.where(user: @people).order(created_at: :desc).offset((@page - 1) * POST_PER_PAGE).limit(POST_PER_PAGE)
    elsif @type == 'following'
      return @people.followings.order(created_at: :desc).offset((@page - 1) * POST_PER_PAGE).limit(POST_PER_PAGE)
    elsif @type == 'followers'
      return @people.followers.order(created_at: :desc).offset((@page - 1) * POST_PER_PAGE).limit(POST_PER_PAGE)
    elsif @type == 'user_index'
      return @people.order(created_at: :desc).offset((@page - 1) * POST_PER_PAGE).limit(POST_PER_PAGE)
    elsif @type == 'notification'
      return Notification.where(user: @people).order(is_read: :asc).order(created_at: :desc).offset((@page - 1) * POST_PER_PAGE).limit(POST_PER_PAGE)
    end
  end
  
  def count_pages
    if @type == 'post'
      return count(Twit.where(user: @people).size)
    elsif @type == 'following'
      return count(@people.followings.size)
    elsif @type == 'followers'
      return count(@people.followers.size)
    elsif @type == 'user_index'
      return count(@people.size)
    elsif @type == 'notification'
      return count(Notification.where(user: @people).size)
    end
  end

  private
    def count(records)
      (records / POST_PER_PAGE).ceil()
    end
end
