require 'rails_helper'
require_relative '../test_utils'

feature "Module #1 models testing", :type => :model do
  include Test_utils
  before(:all) { clear_all_data }
  after (:all) { clear_all_data }

  describe Post, type: :model do
    context "Two posts creates and all fields are filled" do
      it "creating post" do
        post1_title = "Post One Title"
        post1_content = "Some content for Post one"
        post2_title = "Post Two Title"
        post2_content = "Some content for Post two"
        p1 = Post.new(title: post1_title, content: post1_content)
        p2 = Post.new(title: post2_title, content: post2_content)
        expect(p1.title).to eq(post1_title)
        expect(p1.content).to eq(post1_content)
        expect(p2.title).to eq(post2_title)
        expect(p2.content).to eq(post2_content)
      end
    end
    # pending "add some examples to (or delete) #{__FILE__}"
  end

end
