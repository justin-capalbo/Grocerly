FactoryGirl.define do
  factory :user do
    username     { Faker::Internet.user_name }
    email        { Faker::Internet.safe_email(username) }
    password     "password"
    confirmed_at Time.now

    # Generic single list, multiple generic items
    factory :user_with_items do
      after(:create) do |user|
        create(:list_with_items, user: user)
      end
    end

    # Generic single list, no items
    factory :user_with_no_items do
      after(:create) do |user|
        create(:list, user: user)
      end
    end
  end
  
  factory :unconfirmed_user do
    username     { Faker::Internet.user_name }
    email        { Faker::Internet.safe_email(username) }
    password     "password"
  end
end
