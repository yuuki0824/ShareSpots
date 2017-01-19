class RankingController < ApplicationController
  
  def like_ranking
    @title = "like ranking"
    @rank = Like.group(:spot_id).order('count_spot_id desc').limit(10).count('spot_id')
    spot_ids = @rank.keys
    @spots = Spot.find(spot_ids).sort_by{|o| spot_ids.index(o.id)}
  end
  
  def follower_ranking
    @title = "follower_ranking"
    @rank = Relationship.group(:followed_id).order('count_followed_id desc').limit(10).count('followed_id')
    followed_ids = @rank.keys
    @follower = User.find(followed_ids).sort_by{|o| followed_ids.index(o.id)}
  end

end
