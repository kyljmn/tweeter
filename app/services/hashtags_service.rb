class HashtagsService
  def self.hashtag_creator(twit)
    hashtags = twit.body.scan(/#(\w+)/).flatten.uniq
    hashtags.each do |hashtag|
      found_hashtag = Hashtag.find_by("lower(name) = ?", hashtag.downcase)
      if found_hashtag.nil?
        twit.hashtags << Hashtag.create(name: hashtag)
      elsif !twit.hashtags.exists?(id: found_hashtag.id)
        twit.hashtags << found_hashtag
      end
    end
  end
end
