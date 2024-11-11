// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "flatpickr";

document.addEventListener("turbo:load", function () {
    flatpickr(".datepicker", {
        dateFormat: "d-m-Y",
    });
});
