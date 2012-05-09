require 'anemone'
require 'yaml'
require './group_site'
require './meituan'


puts Anemone::Core::DEFAULT_OPTS
#puts Anemone::Core.const_get('DEFAULT_OPTS')



#Ruby Skill
urls = %w{
  http://www.baidu.com
  http://www.google.com
  http://www.sina.com/
  http://www.apple.com/hk
  http://www.taobao.com/
}
links = [urls].flatten.map{ |url| url.is_a?(URI) ? url : URI(url) }
links.each{ |url| url.path = '/' if url.path.empty? }

p links


SITES = YAML.load_file("sites.yaml")
SITES["SITES"].each do|site, links| 
  classname = site.capitalize
  groupsite = classname.  
end