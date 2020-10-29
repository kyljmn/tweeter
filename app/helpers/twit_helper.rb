module TwitHelper
  def render_twit(twit)
    if twit.class.name == "Twit"
      data = { twit: twit }
    elsif twit.class.name == "Retwit"
      data = { twit: twit.twit, retwit: twit }
    end
    render partial:"twits/twit", locals: data
  end

  def render_action(twit)
    if twit.user.id == current_user.id
      link_to "x", user_twit_path(twit.user.id, twit), method: :delete
    elsif !twit.retwits.exists?(retwiter: current_user)
      link_to "Retwit", retwit_twit_path(twit), method: :post
    else
      link_to "Unretwit", unretwit_twit_path(twit), method: :delete
    end
  end

  def render_body(twit)
    return twit.body unless twit.mentions.any?
    processed_body = twit.body.to_s
    twit.mentions.each do |mention|
      processed_body = processed_body.gsub("@#{mention.user.username}", "<a href='/user/#{mention.user.id}'>@#{mention.user.username}</a>")
    end
    return processed_body.html_safe
  end
end
