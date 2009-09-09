class Scrape
  def initialize
    dir = "#{File.dirname(File.expand_path(__FILE__))}/walls/#{Time.now.strftime('%m-%d-%Y')}"
    if File.directory? dir
      @walls_dir = dir
    else
      system "mkdir -p #{dir}"
      @walls_dir = dir
    end

    @thread_base = 'http://orz.4chan.org/wg/'
    @links       = []

    pull_pages
  end

  def pull_pages
    doc = open('http://orz.4chan.org/wg/imgboard.html') { |f| Hpricot f }
    doc.search('/html/body//a').each do |a|
      if a.attributes['href'] =~ /res\/[0-9]{7}/ && a.attributes['href'] !~ /\#/
        @links << a.attributes['href']
      end
    end

    get_images
  end

  def get_images
    @images = []

    @links.each do |page|
      thread = open(@thread_base + page) { |f| Hpricot f }

      thread.search('/html/body//a').each do |a|
        if a.attributes['href'] =~ /wg\/src/ && !@images.find_index(a.attributes['href'])
          @images << a.attributes['href']
        end
      end
    end

    snatch_images
  end

  def snatch_images
    ## @images.each { |image| system "wget -P #{@walls_dir} #{image}" }

    index_images
  end

  def index_images
    @index_dir = "walls/#{Time.now.strftime('%m-%d-%Y')}/"

    @images.each do |image| 
      @pic = image.scan /[0-9]{7}\.[A-z]{3..4}/
      @pic.gsub!(/\[\\\"/, '').gsub!(/\\\"\]/, '')
      Indeximg.new(:img => "#{@index_dir}#{@pic}", :tags => "wallpaper").save
    end
  end
end
