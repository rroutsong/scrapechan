require 'open-uri'
require 'hpricot'
require 'dm-core'
require 'dm-migrations'
require 'mini_magick'

require_relative './lib/scrape'

DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/db/scrape.db")

DataMapper.auto_migrate!

Scrape.new
