require_relative './indeximg'

class Scrape
    def initialize
        dir = "#{File.dirname(File.expand_path(__FILE__))}/walls/#{Time.now.strftime('%m-%d-%Y')}"
        if File.directory? dir
            @walls_dir = dir
        else
            system "mkdir -p #{dir}"
            @walls_dir = dir
        end

        @url = 'http://orz.4chan.org/wg/'
        @images = []

        find_images
        index_images
        dl_images
    end

    def find_images
        @html = Nokogiri::HTML(open(@url)) do |config|
            config.noblanks
        end

        @html.xpath("//a").each do |a|
            if /\.png/i =~ a.attr("href") or /\.jpg/i =~ a.attr("href") or /\.jpeg/i =~ a.attr("href") or /\.tif/i =~ a.attr("href") or /\.gif/i =~ a.attr("href")
                if a.attr("href")[0,2] == "//"
                    img = "http:" + a.attr("href")
                else
                    img = a.attr("href")
                end
                @images << img
            end
        end
    end

    def index_images
    end

    def dl_images
        @images.each do |url|
            begin
                downloadimg(url)
            rescue 
                next
            end
        end
    end

    def downloadimg(url, max_size: nil)
        # source: https://gist.github.com/janko-m/7cd94b8b4dd113c2c193
        url = URI.encode(URI.decode(url))
        url = URI(url)

        filename = /[0-9]*\.[a-zA-Z]{3,4}/i.match(url.path)

        raise Error, "url was invalid" if !url.respond_to?(:open)

        options = {}
        options["User-Agent"] = "ScrapeChan/2.0"
        options[:content_length_proc] = ->(size) {
            if max_size && size && size > max_size
                raise Error, "file is too big (max is #{max_size})"
            end
        }

        img = url.open(options)

        if img.is_a?(StringIO)
            tempfile = Tempfile.new("open-uri", binmode: true)
            IO.copy_stream(img, tempfile.path)
            img = tempfile
            OpenURI::Meta.init img, stringio                 
        end

        IO.copy_stream(img, "./lib/walls/#{Time.now.strftime('%m-%d-%Y')}/#{filename}")
    end
end
