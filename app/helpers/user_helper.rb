module UserHelper
  def get_new_users
    @users = User.all
    return PagesService.new('user_index', @users, 1)
  end
end
