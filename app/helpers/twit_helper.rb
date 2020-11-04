module TwitHelper
  def render_twit(twit)
    render partial:"twits/twit", locals: { twit: twit, author: twit_author(twit) }
  end

  def render_action(twit)
    if !twit.original.retwits.exists?(user: current_user)
      link_to "Retwit", retwit_twit_path(twit.original), method: :post, class: "button" 
    else
      link_to "Unretwit", unretwit_twit_path(twit.original), method: :delete, class: "button"
    end
  end

  def twit_author(twit)
    return twit.owner unless twit.retwit_id.nil?
    return twit.user
  end

  def render_body(twit)
    return twit.body unless twit.original.mentions.any?
    processed_body = twit.body.to_s
    twit.original.mentions.each do |mention|
      processed_body = processed_body.gsub(/@#{mention.user.username}\b/, "<a href='/user/#{mention.user.id}' class='mention' >@#{mention.user.username}</a>")
    end
    return processed_body.html_safe
  end
end
