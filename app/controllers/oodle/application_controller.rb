module Oodle
  class ApplicationController < ::ApplicationController
    include Pagy::Backend

    layout "oodle/application"

    helper Rails.application.helpers
  end
end
