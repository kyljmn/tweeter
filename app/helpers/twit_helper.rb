module TwitHelper
  def render_twit(twit)
    render partial: "twits/twit", locals: { twit: twit, author: twit_author(twit) }
  end

  def render_retwit_action(twit)
    if !twit.original.retwits.exists?(user: current_user)
      link_to retwit_twit_path(twit.original), method: :post do
        content_tag :div, class: "flex items-center p-2 mr-5 rounded-full cursor-pointer hover:bg-twitterLight hover:text-twitter transition duration-900 ease-in-out" do
          content_tag :i, "", class: "fas fa-retweet fa-lg"
          content_tag :span, " Retweet"
        end
      end
    else
      link_to "Unretwit", unretwit_twit_path(twit.original), method: :delete, class: "button"
    end
  end

  def twit_author(twit)
    return twit.owner unless twit.retwit_id.nil?

    twit.user
  end

  def render_body(twit)
    return twit.body unless twit.original.mentions.any? || twit.original.hashtags.any?

    processed_body = twit.body.to_s
    twit.original.mentions.each do |mention|
      processed_body = processed_body.gsub(/@#{mention.user.username}\b/, "<a href='/user/#{mention.user.id}' class='text-twitter'>&nbsp;@#{mention.user.username}&nbsp;</a>")
    end
    twit.original.hashtags.each do |hashtag|
      processed_body = processed_body.gsub(/##{hashtag.name}\b/i) do
        "<a href='/hashtag/#{hashtag.id}' class='mention' >#{Regexp.last_match}</a>"
      end
    end
    processed_body.html_safe
  end
end
