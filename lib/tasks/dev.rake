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
        country: FFaker::AddressUA::country,
        info: FFaker::Lorem::sentence,
        start_at: FFaker::Time::datetime,
        end_at: FFaker::Time::datetime,
        district: "tainan",
        days: rand(1..3)
      )
    end
    30.times do |i|
      day = ["1","2","3"]
      Schedule.create!(
        day: day.sample,
        event: Event.all.sample,
        stay: FFaker::AddressUA::street_address
      )
    end
    60.times do |i|
      Detail.create!(
        schedule: Schedule.all.sample,
        spot: Spot.all.sample,
        hr: rand(1..10),
        content: FFaker::Lorem::sentence
      )
    end
    30.times do |i|
      Reply.create!(
        comment: FFaker::Lorem::sentence,
        user: User.all.sample,
        event: Event.all.sample
      )
    end
    15.times do |i|
      user = User.all.shuffle
      EventsOfUser.create!(user: user.pop, event: Event.all.sample )
    end
    puts Event.count
  end

  task fake_spot: :environment do
    Spot.destroy_all

    spot = ["US","JP","KR","CH","TW","GU","FH","EU"]
    spot.each do |s|
      Spot.create!(spot_name: s)
    end
  end

end