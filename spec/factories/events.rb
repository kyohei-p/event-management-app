FactoryBot.define do
  factory :event do
    name { Faker::Lorem.sentence(word_count: 3) }
    event_description { Faker::Lorem.paragraph(sentence_count: 10) }
    event_day { Faker::Date.between(from: Date.today, to: 6.months.from_now) }
    public_status { Faker::Boolean.boolean ? :open : :closed }
    
    association :category
    association :user
  end
end