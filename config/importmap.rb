# NOTE: this pin works because `my_engine/app/javascript
#       is in the `Rails.application.config.assets.paths`
pin "oodle/application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

pin_all_from "app/javascript/oodle/controllers", under: "controllers"
