require_relative "lib/oodle/version"

Gem::Specification.new do |spec|
  spec.name        = "oodle"
  spec.version     = Oodle::VERSION
  spec.authors     = [ "cisco gonzalez" ]
  spec.email       = [ "cisco.glez@creadix.es", "cisco.glez@gmail.com" ]
  spec.homepage    = "https://railsnew.dev"
  spec.summary     = "Questionnaire system"
  spec.description = "Questionnaire system"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://github.com/ciscoLegrand/oodle.git"

  spec.metadata["homepage_uri"] = "https://railsnew.dev"
  spec.metadata["source_code_uri"] = "https://github.com/ciscoLegrand/oodle.git"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 6.0.0", "< 8.0.0"
  spec.add_dependency "tailwindcss-rails"
  spec.add_dependency "pagy"
  spec.add_dependency "view_component"
  spec.add_dependency 'stimulus-rails'
  spec.add_dependency 'turbo-rails'
  spec.add_dependency 'importmap-rails'
end
