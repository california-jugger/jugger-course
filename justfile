set default-list := true

setup:
    gem install jekyll bundler

serve:
    bundle install
    bundle exec jekyll serve --livereload

build:
    bundle install
    bundle exec jekyll build
