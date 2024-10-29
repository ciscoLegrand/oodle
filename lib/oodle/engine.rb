module Oodle
  class Engine < ::Rails::Engine
    isolate_namespace Oodle

    initializer :append_migrations do |app|
      unless app.root.to_s.match?(root.to_s + File::SEPARATOR)
        app.config.paths["db/migrate"].concat(config.paths["db/migrate"].expanded)
      end
    end

    initializer "oodle.assets" do |app|
      app.config.assets.precompile += %w[oodle_manifest]
    end

    initializer "oodle.importmap", before: "importmap" do |app|
      # NOTE: this will add pins from this engine to the main app
      # https://github.com/rails/importmap-rails#composing-import-maps
      app.config.importmap.paths << root.join("config/importmap.rb")
      # NOTE: something about cache; I did not look into it.
      # https://github.com/rails/importmap-rails#sweeping-the-cache-in-development-and-test
      app.config.importmap.cache_sweepers << root.join("app/javascript")
    end
  end
end
