set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir,  "fonts"

activate :external_pipeline,
  name: :webpack,
  command: build? ? "yarn run build" : "yarn start",
  source: ".tmp/dist",
  latency: 1

configure :development do
  set :domain_name, "http://localhost:4567"
  activate :livereload
end

configure :build do
  ignore { |path| path =~ /\/(.*)\.js|css$/ && $1 != "all" }

  activate :minify_css
  activate :minify_javascript

  activate :relative_assets
end

activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.build_before = true
  deploy.branch   = "master"
  deploy.remote   = "git@github.com:jeffsaracco/jeffsaracco.github.io.git"
end
