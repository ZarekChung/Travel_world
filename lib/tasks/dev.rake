namespace :dev do

  task fake_user: :environment do
    User.destroy_all

    5.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "user#{i}@example.co",
        password: "user123",
        introduction: FFaker::Lorem::sentence(30),
        gender: "female",
        avatar: file
      )

      user.save!
    end

    5.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+10}.jpg")

      user = User.new(
        name: name,
        email: "user#{i+10}@example.co",
        password: "user123",
        introduction: FFaker::Lorem::sentence(30),
        gender: "male",
        avatar: file
      )      

      user.save!
    end

    puts User.count
  end

  task fake_event: :environment do
    Event.destroy_all

    20.times do |i|
      event = Event.create!(
        title: "日本#{i}",
        country: "JP",
        start_at: FFaker::Time::date,
        end_at: FFaker::Time::date,
        district: "東京",
        days: rand(1..3)
      )

      event.days.times do |i|
        event.schedules.create!(
          day: i+=1,
          check_in: "2000-01-01 14:00:00",
          check_out: "2000-01-01 12:00:00"
        )
      end
    end

    60.times do |i|
      Detail.create!(
        schedule: Schedule.all.sample,
        spot: Spot.all.sample,
        hr: "2000-01-01 00:30:00",
        content: FFaker::Lorem::sentence,
        category_id: Category.all.first.id
      )
    end

    Event.all.each do |event|
      users = User.all.sample
      EventsOfUser.create!(user: users, event: event)
    end

    puts Event.count
  end

end