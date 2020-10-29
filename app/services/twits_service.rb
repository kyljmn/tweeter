class TwitsService
  def self.get_twits_retwits(people)
    (Twit.where(user: people) + Retwit.where(retwiter: people)).sort_by(&:created_at).reverse
  end
end
