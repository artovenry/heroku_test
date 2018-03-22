ruby '2.4.3'
# frozen_string_literal: true
source "https://rubygems.org"
git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }


gem "sinatra"
gem "sinatra-contrib"
gem 'activerecord'
gem "rake"
gem "logger"
gem "sinatra-cross_origin"
gem "recaptcha"

group :development do
  gem "mysql2", "~> 0.3.20"
  gem "pry"
  gem "thor"
  gem "racksh"
end

group :staging do
  gem "pg"
end
