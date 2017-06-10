FactoryGirl.define do
  factory :item do
    name { Faker::Food.ingredient }
    notes { Faker::Food.measurement }
    list
  end
end
