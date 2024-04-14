10.times do |n|
  User.create!(name: "test#{n+1}", email: "test#{n+1}@example.com", password: "password#{n+1}", phone_number: "031234000#{n+1}", self_introduction: "テストユーザー#{n+1}です")
end
