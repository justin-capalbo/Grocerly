User.create!(username: "test.account",
             email:    "example@test.com",
             password:              "foobar",
             password_confirmation: "foobar",
             confirmed_at: DateTime.now)

# Lists and items for users
users = User.all

users.each do |user|
  @list = user.lists.create!(name: Faker::Lorem.word)
  50.times do 
    @list.items.create!(name: Faker::Food.ingredient,
                        notes: Faker::Food.measurement)
  end
end
