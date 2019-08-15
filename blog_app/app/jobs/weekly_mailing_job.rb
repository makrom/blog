class WeeklyMailingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    d = Date.current  # Current date
    weekly_digest = Posts.get_posts_by_period(d-7, d)
    User.where(:digest == "weekly").find_each do |user|
      logger.info "Mail #{user.email} weekly digest"
      PostMailer.post_mail(user.email, "Дайджест новостей за неделю", weekly_digest).deliver_later
    end
  end
end
