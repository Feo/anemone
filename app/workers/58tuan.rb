class Tuan < GroupSite

  protected 
  def parse(page)
    deal_intro = page.doc.at(".order_top")
    selling = deal_intro.at("#actPrice")
    if deal_intro && selling
      deal = {
        url: page.url.to_s,
        title: deal_intro.at("h1").text,
        intro: deal_intro.at(".des").text,
        price: deal_intro.at("#actPrice").text,
        image: deal_intro.at(".order_pic > img")[:src],
        type: @type,
        provider: self.class.name
      }
    end
  end
  
  def target_pattern 
    /\d{17}/
  end
  def accept link
    link.to_s =~ /\d{17}/
  end
end
