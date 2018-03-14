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

  task fake_schedules: :environment do
    Schedule.destroy_all

    30.times do |i|
      day = ["1","2","3"]
      Schedule.create!(
        day: day.sample,
        event: Event.all.sample,
        stay: FFaker::AddressUA::street_address
      )
    end
  end

  task fake_event_of_user: :environment do
    15.times do |i|
      user = User.all.shuffle
      EventsOfUser.create!(user: user.pop, event: Event.all.sample )
    end
  end
end