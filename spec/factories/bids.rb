FactoryGirl.define do
  factory :bid do
    association :user, factory: :user
    sequence(:bid_price) {11 + rand(100000)}
    auction
  end
end
