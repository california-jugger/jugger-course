# Prefer rbenv Ruby so recipes work even when the parent shell lacks shims.
export PATH := env_var("HOME") + "/.rbenv/shims:" + env_var("HOME") + "/.rbenv/bin:" + env_var("PATH")

list:
    just --list

setup:
    gem install bundler
    bundle install

serve:
    bundle install
    bundle exec jekyll serve --livereload

build:
    bundle install
    bundle exec jekyll build
