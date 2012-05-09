class Meituan < GroupSite

  protected 
  def parse(page)
    deal_intro = page.doc.at("#deal-intro")
    if deal_intro
      deal = {
        url: page.url.to_s,
        intro: deal_intro.at("h1").text,
        price: deal_intro.at(".deal-price > strong").text,
        image: deal_intro.at(".deal-buy-cover-img > img")[:src],
        type: @type,
        provider: self.class.name
      }
    end
  end
  
  def target_pattern 
    /deal\/.+.html$/
  end
  def accept link
    link.to_s =~ /food|deal/
  end
end
