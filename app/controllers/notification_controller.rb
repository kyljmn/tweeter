class NotificationController < ApplicationController
  def index
    @pager = PagesService.new('notification', current_user, params.fetch(:page, 1).to_i)
  end

  def read
    @notif = Notification.find(params[:id])
    @notif.update(is_read: true) unless @notif.is_read
    if @notif.notifiable_type == 'Mention'
      redirect_to user_twit_path(@notif.notifiable.twit.user, @notif.notifiable.twit)
    end
  end
end
