class PostMailer < ActionMailer::Base
  default from: 'news@blog-app.com'
  def post_mail(subscriber_id, subject, posts)
    @subscriber = User.find subscriber_id
    @posts = posts
    mail(to: @subscriber.email, subject: "Новостная рассылка #{subject}")
  end
end
