class DailyMailingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    d = Date.current
    daily_digest = Posts.get_posts_by_period(d-1, d)
    User.where(:digest == "daily").find_each do |user|
      logger.info "Mail #{user.email} daily digest"
      PostMailer.post_mail(user.email, "Дайджест новостей за день", daily_digest).deliver_later
    end
  end
  # def perform(*args)
  #   d = Date.current  # Current date
  #   monday_now = (d.wday == 1)  # true - if current day of week is monday
  #   daily_digest = Posts.get_posts_by_period(d-1, d)
  #   weekly_digest = Posts.get_posts_by_period(d-7, d) if monday_now
  #   User.where.not(:digest == "no_digest").find_each do |user|
  #     if (user.digest == "weekly") && monday_now  # send weekly digest
  #       logger.info "Mail #{user.email} weekly digest"
  #       PostMailer.post_mail(user.email, "Дайджест новостей за неделю", weekly_digest).deliver_later if weekly_digest
  #       elseif (user.digest == "daily")
  #       logger.info "Mail #{user.email} daily digest"
  #       PostMailer.post_mail(user.email, "Дайджест новостей за день", daily_digest).deliver_later if daily_digest
  #     else
  #       logger.info "Don't mail #{user.email} any digest"
  #     end
  #   end
  #   self.class.perform_later(wait_until: Date.tomorrow.7.hours)
  # end
end
