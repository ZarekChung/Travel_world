namespace :dev do
  task fake_user: :environment do
    User.destroy_all
    10.times do |i|
      name = FFaker::Name::first_name

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(30),
        gender: FFaker::Gender::random,
        remote_avatar_url: "http://lorempixel.com/250/250/sports/",
      )

      user.save!
      puts user.name
    end
  end
end