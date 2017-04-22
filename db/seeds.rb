# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
case Rails.env
when "development"
  user = User.new
  user.email = "test4@test.com"
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.approved = false
  user.save!
  end
end
