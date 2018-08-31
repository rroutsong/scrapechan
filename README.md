
# scrapechan    

like wallpapers? don't like the content on 4chan? here is a:

ruby script for scraping and indexing wallpapers from 4chan board /wg/

### Prerequisites

open-uri
nokogiri
mini_magick
datamapper {core,migrations,sqlite-adapter}

### Installing

git clone https://github.com/rroutsong/scrapechan.git

gem install datamapper dm-migrations dm-sqliteadapter mini_magick hpricot open_uri

ruby scrape.rb

Not working entirely as of 8/31/2018

### TODO
* Write tests
* Add more functionality to indexing
* Recognition of graphic images and optional exclusion of said images from index and download, using(at first): [sstephenson/execjs](https://github.com/sstephenson/execjs) & [pa7/nude.js](https://github.com/pa7/nude.js)
  * Then recreate this [algorithm](https://sites.google.com/a/dcs.upd.edu.ph/csp-proceedings/Home/pcsc-2005/AI4.pdf?attredirects=0) in ruby and utilize that


### License

This project is unlicensed and free for use and manipulation - see the [LICENSE.md](LICENSE.md) file for details.
