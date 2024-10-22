module Oodle
  class ApplicationController < ::ApplicationController # Hereda del ApplicationController principal
    layout "oodle/application" # Sigue usando el layout de la engine

    # Incluir los helpers de la aplicación principal
    helper Rails.application.helpers
  end
end
