module UserHelper
  def fetch_new_users
    @users = User.all
    PagesService.new("user_index", @users, 1)
  end
end
