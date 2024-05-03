require 'date'

#ユーザー
10.times do |n|
  user = User.create!(name: "test#{n+1}", email: "test#{n+1}@example.com", password: "password#{n+1}", phone_number: "031234000#{n+1}", self_introduction: "テストユーザー#{n+1}です")
  user.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.png')), filename: 'default_avatar.png')
end

#カテゴリー
Category.create!(name: "交流会")
Category.create!(name: "勉強会")
Category.create!(name: "セミナー")
Category.create!(name: "芸術")
Category.create!(name: "営業・販売")
Category.create!(name: "コーチング")
Category.create!(name: "カウンセリング")
Category.create!(name: "経営・起業")
Category.create!(name: "ワークショップ")
Category.create!(name: "ファイナンス")
Category.create!(name: "サークル")
Category.create!(name: "就活")
Category.create!(name: "転職活動")
Category.create!(name: "副業・キャリア")
Category.create!(name: "趣味・ライフスタイル")
Category.create!(name: "福祉・医療")
Category.create!(name: "スポーツ")
Category.create!(name: "ヨガ・フィットネス")
Category.create!(name: "ファッション")
Category.create!(name: "美容・健康")
Category.create!(name: "音楽")
Category.create!(name: "ゲーム")
Category.create!(name: "料理・グルメ")
Category.create!(name: "心理学・スピリチュアル")
Category.create!(name: "プログラミング")
Category.create!(name: "語学学習")
Category.create!(name: "資格取得")
Category.create!(name: "旅行")
Category.create!(name: "婚活・恋活")
Category.create!(name: "ボランティア")

#イベント
start_day = Date.parse("2024-06-01")
last_day = Date.parse("2024-12-31")

image_path = {
  1 => Rails.root.join('app', 'assets', 'images', 'events', 'seminar.png'),
  2 => Rails.root.join('app', 'assets', 'images', 'events', 'engineer.png'),
  3 => Rails.root.join('app', 'assets', 'images', 'events', 'seminar.png'),
  4 => Rails.root.join('app', 'assets', 'images', 'events', 'art.png'),
  5 => Rails.root.join('app', 'assets', 'images', 'events', 'sales.png'),
  6 => Rails.root.join('app', 'assets', 'images', 'events', 'consultation.png'),
  7 => Rails.root.join('app', 'assets', 'images', 'events', 'consultation.png'),
  8 => Rails.root.join('app', 'assets', 'images', 'events', 'startup.png'),
  9 => Rails.root.join('app', 'assets', 'images', 'events', 'seminar.png'),
  10 => Rails.root.join('app', 'assets', 'images', 'events', 'finance.png'),
  11 => Rails.root.join('app', 'assets', 'images', 'events', 'circle.png'),
  12 => Rails.root.join('app', 'assets', 'images', 'events', 'recruit.png'),
  13 => Rails.root.join('app', 'assets', 'images', 'events', 'recruit.png'),
  14 => Rails.root.join('app', 'assets', 'images', 'events', 'seminar.png'),
  15 => Rails.root.join('app', 'assets', 'images', 'events', 'lifestyle.png'),
  16 => Rails.root.join('app', 'assets', 'images', 'events', 'medical_care.png'),
  17 => Rails.root.join('app', 'assets', 'images', 'events', 'sport.png'),
  18 => Rails.root.join('app', 'assets', 'images', 'events', 'yoga.png'),
  19 => Rails.root.join('app', 'assets', 'images', 'events', 'fashion.png'),
  20 => Rails.root.join('app', 'assets', 'images', 'events', 'beauty.png'),
  21 => Rails.root.join('app', 'assets', 'images', 'events', 'music.png'),
  22 => Rails.root.join('app', 'assets', 'images', 'events', 'game.png'),
  23 => Rails.root.join('app', 'assets', 'images', 'events', 'cooking.png'),
  24 => Rails.root.join('app', 'assets', 'images', 'events', 'spiritual.png'),
  25 => Rails.root.join('app', 'assets', 'images', 'events', 'engineer.png'),
  26 => Rails.root.join('app', 'assets', 'images', 'events', 'language.png'),
  27 => Rails.root.join('app', 'assets', 'images', 'events', 'qualification.png'),
  28 => Rails.root.join('app', 'assets', 'images', 'events', 'travel.png'),
  29 => Rails.root.join('app', 'assets', 'images', 'events', 'love.png'),
  30 => Rails.root.join('app', 'assets', 'images', 'events', 'volunteer.png'),
}

100.times do |n|
  user_id = User.pluck(:id).sample
  category_id = Category.pluck(:id).sample

  category_image = image_path[category_id]

  event = Event.create!(
    user_id: user_id,
    category_id: category_id,
    name: "イベント#{n+1}",
    event_description: "イベント#{n+1}の説明です。",
    event_day: rand(start_day..last_day),
    public_status: 1
  )

  begin
    event.image.attach(io: File.open(category_image), filename: "event_image#{n+1}.png")
  rescue StandardError => e
    puts "event_id:#{event.id}"
    puts e.class
    puts "画像のアタッチ中に#{e.class}が発生しました: #{e.message}"
  end
end