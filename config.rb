activate :livereload

set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'images'
set :fonts_dir,  "fonts-folder"

compass_config do |config|
  config.add_import_path "./components"
end

after_configuration do
  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  sprockets.append_path File.join "#{root}", @bower_config["directory"]
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :relative_assets
end

activate :deploy do |deploy|
  deploy.method = :git
  deploy.build_before = true
  deploy.branch   = "master"
  deploy.remote   = "git@github.com:jeffsaracco/jeffsaracco.github.io.git"
end
