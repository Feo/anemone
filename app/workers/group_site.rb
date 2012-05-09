

class GroupSite
    
  OPTIONS = {
    :threads => 8, 
    :verbose => true, 
    :discard_page_bodies => false, 
    :user_agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:11.0) Gecko/20100101 Firefox/11.0", 
    :delay => 0, 
    :obey_robots_txt => true, 
    :depth_limit => 2, 
    :redirect_limit => 5, 
    :storage => nil, 
    :cookies => nil, 
    :accept_cookies => false, 
    :skip_query_strings => false, 
    :proxy_host => nil, 
    :proxy_port => false, 
    :read_timeout => nil
  }
  
  def initialize(links, type, block_css = '#content')
    @links = links
    @type = type
    @block_css = block_css
    @target_pattern = target_pattern
  end

  
  def start(options = {})
    options = OPTIONS.merge(options)
    Anemone.crawl(@links, options) do |core|
      core.focus_crawl{|page|
        follow_links page
      }.on_pages_like(target_pattern){|page|
        handle page
      }.after_crawl { |pagestore|
        finish pagestore
      }
    end
  end
  
  
  protected  
  def handle(page)
    deal = parse page
    begin
      puts deal
#      Deal.new(deal).save! if deal   
    rescue Error => e
      puts e
    end
  end  
  
  def target_pattern
    /./ #anything
  end
    
  def finish pagestore
    puts "Finish crawl see #{pagestore.class}"
#    pagestore.each do |url, page|
#    end
  end

  private   
  def follow_links(page)
    links = []
    if page.doc
      content = page.doc.at(@block_css) 
      get_links(content, page.url).each do |link|
        links << link if accept link
      end     
    end
    links
  end
  
  def accept link
    true
  end
  
  def get_links(node, base)
    return [] if !node
    links = []
    node.css("a[href]").each do |a|
      u = a['href']
      next if u.nil? or u.empty?
      u = base.scheme + "://" + base.host + u if u.start_with?("/")
      link = URI(URI.escape(u)) rescue next     
      links << link if link.host == base.host
    end
    links.uniq!
    links
  end
end
