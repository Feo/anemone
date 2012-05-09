class Lashou < GroupSite

  protected 
  def parse(page)
    deal_intro = page.doc.at(".con-mid")
    if deal_intro
      deal = {
        url: page.url.to_s,
        intro: deal_intro.at("h1").text,
        price: deal_intro.at(".c-buy-num").text,
        image: deal_intro.at(".c-pro-image > img")[:src],
        type: @type,
        provider: self.class.name
      }
    end
  end
  
  def target_pattern 
    /deal\/.+.html$/
  end
  def accept link
    link.to_s =~ /meishi|deal/
  end
end
