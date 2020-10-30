class TwitsService
  def self.get_twits_retwits(people)
    Post.where(user: people).order(created_at: :desc).limit(5)
    # (Twit.where(user: people) + Retwit.where(retwiter: people)).sort_by(&:created_at).reverse
  end
end
