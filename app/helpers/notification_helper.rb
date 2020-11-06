module NotificationHelper
  def notif_link(notif)
    link_to notif_message(notif), read_notification_path(notif), method: :patch, class: "link"
  end

  def notifying_user(notif)
    return notif.notifiable.twit.user if notif.notifiable_type == "Mention"
  end

  def notif_message(notif)
    if notif.notifiable_type == 'Mention'
      return "<span class=\"font-bold\">@#{notifying_user(notif).username}</span> mentioned you".html_safe 
    end
  end

  def notif_status(notif)
    if notif.is_read
      '<span class="read">Read</span>'.html_safe
    else
      '<span class="unread">Unread</span>'.html_safe
    end
  end
end
