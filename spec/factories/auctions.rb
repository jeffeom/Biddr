FactoryGirl.define do
  factory :auction do

    association :user, factory: :user

    sequence(:title) {Faker::Company.bs}
    details Faker::Lorem.paragraph
    sequence(:reserve_price) {11 + rand(100000)}
    end_date  60.days.from_now
  end
end




# 
#     title "MyString"
# details "MyText"
# end_date "2015-12-11 09:29:47"
# reserve_price ""
# aasm_state "MyString"
#   end
#
# end
