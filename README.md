
# scrapechan    

ruby script for scraping and indexing wallpapers from 4chan board /wg/

### Prerequisites

open-uri
hpricot
mini_magick
datamapper {core,migrations,sqlite-adapter}

### Installing

git clone https://github.com/rroutsong/scrapechan.git

gem install datamapper dm-migrations dm-sqliteadapter mini_magick hpricot open_uri

ruby scrape.rb

Not working entirely as of 8/31/2018

### TODO
* Update old version to work with new /wg/ board url, and tags
* Write tests
* Add more functionality to indexing
* Recognition of graphic images and optional exclusion of said images from index and download, using: [ch2h/isporn](https://github.com/c2h2/isporn)

### License

This project is unlicensed and free for use and manipulation - see the [LICENSE.md](LICENSE.md) file for details.
