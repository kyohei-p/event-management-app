# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

Rails.application.config.serve_static_assets = true

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile +=
%w(
  bootstrap.min.js
  popper.js
  *.js *.css *.png
  smartphone_comp.png
  default_avatar.png
  events/no_image.png
  categories/art.png
  categories/medical_care.png
  categories/beauty.png
  categories/music.png
  categories/circle.png
  categories/qualification.png
  categories/consultation.png
  categories/recruit.png
  categories/cooking.png
  categories/sales.png
  categories/engineer.png
  categories/seminar.png
  categories/fashion.png
  categories/spiritual.png
  categories/finance.png
  categories/sport.png
  categories/game.png
  categories/startup.png
  categories/language.png
  categories/travel.png
  categories/lifestyle.png
  categories/volunteer.png
  categories/love.png
  categories/yoga.png
  application.css
  login.css
  events/index.css
  events/pagination.css
  events/manage_index.css
  events/show.css
  shared/colors.css
  shared/footer.css
  shared/more-list-btn.css
  shared/common.css
  shared/header.css
  shared/reset.css
  shared/error.css
  shared/modal.css
  users/mypage.css
)