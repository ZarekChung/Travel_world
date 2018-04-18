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

    200.times do |i|
      c = rand(0..3)
      t = Time.new(FFaker::Time::date)
      days = rand(1..3)
      country = ["日本","日本","香港","韓國"]
      country_code = ["JP","JP","HK","KR"]
      word = [FFaker::LoremJA::word,FFaker::LoremJA::word,FFaker::LoremCN::word,FFaker::LoremKR::word]
      description = ["好玩行程","好美","讚","棒行程","～超棒行","懶人行","最酷行程","我最棒！","好玩","炫行程","酷酷行","行","超好玩！"]
      district = ["東京","大阪","香港",FFaker::AddressKR::metropolitan_city]
      address = [FFaker::AddressJA::tokyo_ward_address,"1 Chome-10-36 Nishishinsaibashi, Chuo, Osaka, Osaka Prefecture 542-0086","香港尖沙咀德興街7-8號",FFaker::AddressKR::land_address]
      stay = ["東京飯店","大阪飯店","香港港龍酒店","韓國飯店"]

      event = Event.create!(
        title: country[c]+word[c]+description.sample,
        country: country_code[c], 
        start_at: t,
        end_at: t + ((days-1) * 60 * 60 * 24),
        district: district[c],
        days: days
      )

      event.days.times do |i|
        event.schedules.create!(
          day: i+=1,
          check_in: "2000-01-01 14:00:00",
          check_out: "2000-01-01 12:00:00",
          stay: stay[c],
          address: address[c],
          airplane_name: FFaker::Airline::name,
          airplane_number: FFaker::Airline::flight_number,
          airplane_terminal: rand(1..2),
          airplane_time: FFaker::Time::datetime
        )
      end

        event.schedules.each do |schedule|
          3.times do |s| 
            spot = [Spot.all.where("address LIKE ?","%Tōkyō%日本%"),Spot.all.where("address LIKE ?","%Osaka%日本%"),Spot.all.where("address LIKE ?","%香港%"),Spot.all.where("address LIKE ?","%韓國%")]
            Detail.create!(
              schedule: schedule,
              spot: spot[c].sample,
              hr: "2000-01-01 00:30:00",
              content: FFaker::Lorem::sentence,
              category_id: Category.all.first.id
            )
        end
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