module Test_utils

  #clear all data from database
  def clear_all_data
    Post.delete_all
    User.delete_all
  end

  #helper method to determine if Ruby class exists as a class
  def class_exists?(class_name)
    eval("defined?(#{class_name}) && #{class_name}.is_a?(Class)") == true
  end

end
