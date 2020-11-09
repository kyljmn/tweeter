module UserHelper
  def fetch_new_users
    @users = User.all
    PagesService.new("user_index", @users, 1)
  end

  def fetch_current_user
    current_user.profile_picture
  end

  def fetch_to_follow_users
    @users = User.all.sample(5)
  end
end
