import "bootstrap"
import "@hotwired/turbo-rails"
import "controllers"
import "./preview"
import "./flash"

$(function() {
  $('.flash-message').fadeOut(5000);
});