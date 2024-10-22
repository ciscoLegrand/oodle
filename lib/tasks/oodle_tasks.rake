# desc "Explaining what the task does"
# task :oodle do
#   # Task goes here
# end
task :tailwind_engine_watch do
  system "bin/rails tailwindcss:watch -i #{Oodle::Engine.root.join("app/assets/stylesheets/application.tailwind.css")} \
         -o #{Oodle::Engine.root.join("app/assets/builds/oodle.css")} \
         -c #{Oodle::Engine.root.join("config/tailwind.config.js")}"
end
