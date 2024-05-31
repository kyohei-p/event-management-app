import "bootstrap"
import "@hotwired/turbo-rails"
import "controllers"
import "./preview"
import "./flash"
import "./more_list_btn"

$(function() {
  $('.flash-message').fadeOut(5000);
});