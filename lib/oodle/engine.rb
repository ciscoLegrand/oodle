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
  end
end
