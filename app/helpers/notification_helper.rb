module NotificationHelper
  def notif_link(notif)
      return link_to notif_message(notif), read_notification_path(notif), method: :patch
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
      return "Read"
    else
      return "Unread"
    end
  end
end
