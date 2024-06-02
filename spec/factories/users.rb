FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    self_introduction { Faker::Lorem.paragraph(sentence_count: 10) }
    phone_number { Faker::Number.leading_zero_number(digits: 11) }
    password { Faker::Internet.password(min_length: 8, max_length: 16) }
  end
end