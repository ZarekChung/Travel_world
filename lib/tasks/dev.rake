namespace :dev do
  task fake_user: :environment do
    User.destroy_all

    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "user#{i}@example.co",
        password: "user123",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
    end

    puts User.count
  end

  task fake_event: :environment do
    Event.destroy_all

    20.times do |i|
      Event.create!(
        title: "Phase#{i}",
        country: FFaker::AddressUA::country
      )
    end
    puts Event.count
  end

  task fake_event_of_user: :environment do
    15.times do |i|
      user = User.all.shuffle
      EventsOfUser.create!(user: user.pop, event: Event.all.sample )
    end
  end
end