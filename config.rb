activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

activate :relative_assets
set :relative_links, true

activate :directory_indexes

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true

activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.branch   = 'gh-pages'
end

activate :livereload

activate :blog do |blog|
  blog.prefix = "blog"
  blog.permalink = "{title}.html"
end
