namespace :fill do
  desc 'Fill data'
  task data: :environment do
    require 'faker'
    require 'populator'

    puts 'Creating users'
    puts '=============='

    password = 'dddd4444'

    User.populate 20 do |user|
      user.first_name = Faker::Name.first_name
      user.last_name = Faker::Name.last_name
      user.email = Faker::Internet.email
      user.phone = Faker::PhoneNumber.cell_phone
      user.encrypted_password = User.new(password: password).encrypted_password
      user.sign_in_count = 0
      user.address = Faker::Address.street_address
      user.zip = Faker::Address.zip
      user.city = Faker::Address.city
      user.state = Faker::Address.state
      user.approved = false
      user.affiliation = 'Locksmith'
      user.admin = false
      user.failed_attempts = 0

      puts "created user #{user.first_name}   #{user.last_name}"
    end

    user.skip_confirmation!
    user.save!

  end
end
