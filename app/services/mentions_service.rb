class MentionsService
  def self.mention_creator(twit)
    mentioned_usernames = twit.body.scan(/@(\w+)/).flatten.uniq
    if !mentioned_usernames.empty?
      mentioned_usernames.each do |username|
        mentioned_user = User.find_by(username: username)
        Mention.create(user: mentioned_user, twit: twit)
      end
    end
  end
end
