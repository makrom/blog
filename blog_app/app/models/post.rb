class Post < ApplicationRecord
  def get_posts_by_period(:from_time, :to_time)
    result = Post.where("created_at >= ? AND created_at <= ?", :from_time, :to_time).order(created_at: :desc).to_a
  end
end
