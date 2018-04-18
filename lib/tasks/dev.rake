namespace :dev do

  task fake_user: :environment do
    User.destroy_all

    5.times do |i|
      name = FFaker::Name::first_name_female
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
      name = FFaker::Name::first_name_male
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

    50.times do |i|
      t = Time.new(FFaker::Time::date)
      days = rand(1..3)
      event = Event.create!(
        title: "日本#{FFaker::LoremJA::word}行程！",
        country: "JP",
        start_at: t,
        end_at: t + ((days-1) * 60 * 60 * 24),
        district: FFaker::AddressJA::tokyo_ward,
        days: days
      )

      event.days.times do |i|
        event.schedules.create!(
          day: i+=1,
          check_in: "2000-01-01 14:00:00",
          check_out: "2000-01-01 12:00:00",
          stay: "hotel",
          address: FFaker::AddressJA::tokyo_ward_address,
          airplane_name: FFaker::Airline::name,
          airplane_number: FFaker::Airline::flight_number,
          airplane_terminal: rand(1..2),
          airplane_time: FFaker::Time::datetime
        )
      end
    end

    3.times do |i|
      Schedule.all.each do |schedule|
        Detail.create!(
          schedule: schedule,
          spot: Spot.all.sample,
          hr: "2000-01-01 00:30:00",
          content: FFaker::Lorem::sentence,
          category_id: Category.all.first.id
        )
      end
    end

    Event.all.each do |event|
      users = User.all.sample
      EventsOfUser.create!(user: users, event: event)
    end

    puts Event.count
  end

  task fake_reply: :environment do
    Event.all.each do |event|   
      3.times do |i|
        event.replies.create!(
          comment: FFaker::Lorem.sentence,
          user: User.all.sample,
          number: rand(1..5))
      end
    end
    puts Reply.count
  end

  task fake_favorite: :environment do
    Event.all.each do |event| 
      30.times do |i|      
        users = User.all.sample
        users.favorites.create(event: event)
      end
    end
    puts Favorite.count
  end

  task fake_clone: :environment do
    Event.all.each do |event| 
      clone = event.amoeba_dup  
      org_user = EventsOfUser.find_by(event: event).user
      users = User.all.sample
        users.events_of_users.create!(
          event: clone, 
          org_user: org_user.id, 
          org_event: event.id
        )
    end
    puts "clone"
  end

end