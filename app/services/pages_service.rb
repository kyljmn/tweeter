class PagesService
  POST_PER_PAGE = 10.0
  attr_accessor :page
  def initialize(type, people, page)
    @people = people
    @page = page
    @type = type
  end
  def get_posts
    if @type == 'post'
      return Post.where(user: @people).order(created_at: :desc).offset((@page - 1)*POST_PER_PAGE).limit(POST_PER_PAGE)
    end
  end
  def count_pages
    if @type == 'post'
      return (Post.where(user: @people).size / POST_PER_PAGE).ceil()
    end
  end
end
