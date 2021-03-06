require "builder"

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

activate :asset_hash
activate :directory_indexes
activate :livereload

command =
  if build?
    "./node_modules/webpack/bin/webpack.js --bail -p"
  else
    "./node_modules/webpack/bin/webpack.js --watch -d --progress --color"
  end

external_pipeline_options = {
  name: :webpack, command: command, source: ".tmp/dist", latency: 1
}

activate :external_pipeline, external_pipeline_options

set :relative_links, true

configure :development do
  config[:css_dir] = ".tmp/dist"
  config[:js_dir]  = ".tmp/dist"
end

page "/*.xml",        layout: false
page "/*.json",       layout: false
page "/*.txt",        layout: false
page "/sitemap.html", layout: false

configure :build do
  config[:http_prefix] = ""
  config[:css_dir]     = ""
  config[:js_dir]      = ""
end
