require "rails_helper"
require_relative '../test_utils'

feature "Module #2 mailers testing", :type => :model do
  include Test_utils
  before(:all) { clear_all_data }
  after (:all) { clear_all_data }

  describe PostMailer, type: :mailer do
    context "Generate and send email" do
      post1_title = "Post One Title"
      post1_content = "Some content for Post one"
      post2_title = "Post Two Title"
      post2_content = "Some content for Post two"
      it "delivery daily digest" do
        expect(p0 = Post.create(title: post1_title, content: post1_content)).to_not be_nil
        expect(p0.save).to be true
        expect(p0 = Post.create(title: post2_title, content: post2_content)).to_not be_nil
        expect(p0.save).to be true
        # expect(daily_digest = Post.all.to_a).to_not eq([])
        t = Time.current
        expect(daily_digest = Post.where("created_at >= ? AND created_at <= ?", t-1.day, t).order(created_at: :desc).to_a).to_not eq([])
        mail_to = 'user@email.co'
        subj = "Дайджест новостей за день"
        pm = PostMailer.post_mail(mail_to, subj, daily_digest)
        expect(pm.subject).to have_text(subj)
        expect(pm.to).to eq([mail_to])
        expect(pm.from).to eq(['news@blog-app.com'])
        expect(pm.body.encoded).to have_text(post1_title)
        expect(pm.body.encoded).to have_text(post2_title)
        expect(pm.body.encoded).to have_text(post1_content)
        expect(pm.body.encoded).to have_text(post2_content)
      end
      it "delivery weekly digest" do
        expect(p0 = Post.create(title: post1_title, content: post1_content)).to_not be_nil
        expect(p0.save).to be true
        expect(p0 = Post.create(title: post2_title, content: post2_content)).to_not be_nil
        expect(p0.save).to be true
        # expect(daily_digest = Post.all.to_a).to_not eq([])
        t = Time.current
        expect(weekly_digest = Post.where("created_at >= ? AND created_at <= ?", t-7.day, t).order(created_at: :desc).to_a).to_not eq([])
        mail_to = 'user@email.co'
        subj = "Дайджест новостей за день"
        pm = PostMailer.post_mail(mail_to, subj, weekly_digest)
        expect(pm.subject).to have_text(subj)
        expect(pm.to).to eq([mail_to])
        expect(pm.from).to eq(['news@blog-app.com'])
        expect(pm.body.encoded).to have_text(post1_title)
        expect(pm.body.encoded).to have_text(post2_title)
        expect(pm.body.encoded).to have_text(post1_content)
        expect(pm.body.encoded).to have_text(post2_content)
      end
    end
    # pending "add some examples to (or delete) #{__FILE__}"
  end

end
