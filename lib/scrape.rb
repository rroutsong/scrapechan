require 'open-uri'
require 'hpricot'
require 'dm-core'
require 'mini_magick'

require 'scrape/scrape'
require 'scrape/indeximg'

DataMapper.setup(:default, "sqlite3:///#{Dir.pwd}/scrape.db")

DataMapper.auto_migrate!

Scrape.new
