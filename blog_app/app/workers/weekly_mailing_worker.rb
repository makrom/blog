class WeeklyMailingWorker
  include Sidekiq::Worker

  def perform(*args)
    d = Date.current  # Current date
    weekly_digest = Post.where("created_at >= ? AND created_at <= ?", d-7, d).order(created_at: :desc).to_a
    if weekly_digest != []
      User.where(:digest == "weekly").find_each do |user|
        logger.info "Mail #{user.email} weekly digest"
        PostMailer.post_mail(user.email, "Дайджест новостей за неделю", weekly_digest).deliver_now
      end
    else
      logger.info "Nothing mail weekly digest"
    end
  end
end
