require "rubygems" #
require "nokogiri" #
require "open-uri" #
####################
page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
#----------------------------------------------------------------------

