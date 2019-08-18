class PostMailer < ActionMailer::Base
  default from: 'news@blog-app.com'
  def post_mail(subscriber_email, subject, posts)
    @posts = posts
    mail(to: subscriber_email, subject: "Новостная рассылка #{subject}")
  end
end
