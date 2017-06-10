FactoryGirl.define do
  factory :list do
    name { Faker::Lorem.word }
    user

    # List with 50 items
    factory :list_with_items do
      after(:create) do |list|
        50.times do |n|
          create(:item, list: list)
        end
      end
    end
  end
end
