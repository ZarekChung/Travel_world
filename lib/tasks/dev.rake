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
      Event.create!(
        title: "日本#{i}",
        country: "JP",
        start_at: FFaker::Time::datetime,
        end_at: FFaker::Time::datetime,
        district: "東京",
        days: rand(1..3)
      )
    end
    30.times do |i|
      day = ["1","2","3"]
      Schedule.create!(
        day: day.sample,
        event: Event.all.sample,
      )
    end
    60.times do |i|
      Detail.create!(
        schedule: Schedule.all.sample,
        spot: Spot.all.sample,
        hr: rand(1..10),
        content: FFaker::Lorem::sentence,
        category_id: 1
      )
    end

    Event.all.each do |event|
      users = User.all.sample
      EventsOfUser.create!(user: users, event: event)
    end
    puts Event.count
  end

  task fake_spot: :environment do
    Spot.destroy_all

    file = File.open("#{Rails.root}/public/avatar/spot#{rand(1..5)}.jpg")

    spot = ["US","JP","KR","CH","TW","GU","FH","EU"]
    spot.each do |s|
      Spot.create!(
        spot_name: s,
        image: file
      )
    end
    puts Spot.count
  end

end