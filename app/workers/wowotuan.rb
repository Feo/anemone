class Wowotuan < GroupSite

  protected 
  def parse(page)
    deal_intro = page.doc.at(".xq_dz")
    if deal_intro
      deal = {
        url: page.url.to_s,
        intro: deal_intro.at(".xq_titlea").text,
        price: deal_intro.at(".xq_qiang").text,
        image: deal_intro.at(".xq_img")[:src],
        type: @type,
        provider: self.class.name
      }
    end
  end
  
  def target_pattern 
    /goods-[a-z0-9]{16}/
  end
  def accept link
    link.to_s =~ /goods-[a-z0-9]{16}/
  end
end
