class DailyMailingWorker
  include Sidekiq::Worker

  def perform(*args)
    d = Date.current
    daily_digest = Post.where("created_at >= ? AND created_at <= ?", d-1, d).order(created_at: :desc).to_a
    if daily_digest != []
      User.where(:digest == "daily").find_each do |user|
        logger.info "Mail #{user.email} daily digest"
        PostMailer.post_mail(user.email, "Дайджест новостей за день", daily_digest).deliver_now
      end
    else
      logger.info "Nothing mail daily digest"
    end
  end
end
