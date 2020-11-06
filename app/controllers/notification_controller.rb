class NotificationController < ApplicationController
  before_action :authenticate_user!
  def index
    @pager = PagesService.new("notification", current_user, params.fetch(:page, 1).to_i)
  end

  def read
    @notif = Notification.find(params[:id])
    @notif.update(is_read: true) unless @notif.is_read
    redirect_to user_twit_path(@notif.notifiable.twit.user, @notif.notifiable.twit) if @notif.notifiable_type == "Mention"
  end
end
