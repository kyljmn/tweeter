module NotificationHelper
  def notif_link(notif)
      return link_to notif_message(notif), read_notification_path(notif), method: :patch, class: "link"
  end

  def notifying_user(notif)
    if notif.notifiable_type == 'Mention'
      return notif.notifiable.twit.user
    end
  end

  def notif_message(notif)
    if notif.notifiable_type == 'Mention'
      return notifying_user(notif).username + " mentioned you"
    end
  end

  def notif_status(notif)
    if notif.is_read
      return "<span class=\"read\">Read</span>".html_safe
    else
      return "<span class=\"unread\">Unread</span>".html_safe
    end
  end
end
