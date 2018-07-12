require "rubygems" #
require "nokogiri" #
require "open-uri" #
####################
page = Nokogiri::HTML(open("http://www.nokogiri.org/tutorials/installing_nokogiri.html"))
#------------------------------------------------------
puts page.class
puts
# Selectionner un élément
puts page.css("title") # garde balise
puts
puts page.css("title").text   # TEXT enlève balise
puts page.css("title")[0].text
puts page.css("title")[0].content # CONTENT = TEXT
puts 
puts page.css("title")[0].name # NAME donne la balise
puts "-"*20
# Selectionner l'attribut d'un élément
links = page.css("a")

puts links.length # LENGTH donne nb d'élément (ici <a>)
puts links[1].text
puts
puts "AFFICHAGE DU LIEN HREF:" # recuperer lien
10.times do |i|
	puts links[i]["href"]
end
puts
#SELECT (pour collection)
newLink = page.css("a").select{|link| link['data-category']=="news"}
newLink.each{|link| puts link["href"]}
puts newLink.class



puts
page.css("nav ul.menu li a", "article2").each do |link|
	puts link.content
end


##the_id_name_here
#.the_classname_here
