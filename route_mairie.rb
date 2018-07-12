require "rubygems" #
require "nokogiri" #
require "open-uri" #
####################
## !!!!!!
# A REVOIR
# FAIRE METHODE QUI ECRIS LES URL
# + HISTOIRE
# !!!!!!!


# ----------------  Il voudrait toutes les adresses email des mairies du Val d'Oise ----------------


#prend en paramètre : url_mairie
#renvoie hash (nomVille => adrMailMairie)
def get_the_email_of_a_townhal_from_its_webpage(url_mairie)
	#------------------------------------------------------
	page = Nokogiri::HTML(open(url_mairie))
	#------------------------------------------------------
	nom = page.css("div[class='col-md-12 col-lg-10 col-lg-offset-1'] h1").text
	adr = page.css("tbody tr")[3].css("td")[1].text
	return nomAdrMairie = { nom => adr }
end


#prend en paramètre : url de liste des mairie d'une région
#renvoie une liste contenant les : url_mairie
def get_all_the_urls_of_val_doise_townhalls(url_liste_mairie) 
	#------------------------------------------------------
	page = Nokogiri::HTML(open(url_liste_mairie))
	#------------------------------------------------------
	liste = []
	liste_balise = page.css("table a[class ='lientxt']")
	liste_balise.length.times{|i| liste.push(liste_balise[i]["href"])}
	return liste 
end


#prend en paramètre : nom de region
#renvoit les adresses de ses mairies
def global(lieu_voulu)
	url_regions = "http://annuaire-des-mairies.com/"
	url_debut_site = "http://annuaire-des-mairies.com/"

	urlAnnuaireMairie = url_debut_site
	urlMairie = url_debut_site
	#------------------------------------------------------
	page = Nokogiri::HTML(open(url_regions))
	#------------------------------------------------------
	lieu = page.css("div[class='container'] a[class='lientxt']")
	# puts lieu.text
	lieu.length.times do |i| 
		if lieu_voulu==lieu[i].text
			#ecrire lien site
			urlAnnuaireMairie += "#{lieu[i]["href"]}"
			#recuperer les url mairie
			liste_url_mairie = get_all_the_urls_of_val_doise_townhalls(urlAnnuaireMairie)
			#recuperer l'adresse mail pour chacune des mairies de la liste
			liste_url_mairie.each do |url|
				urlMairie += "#{url}"
				hash_Mairie = get_the_email_of_a_townhal_from_its_webpage(urlMairie)
				puts hash_Mairie

				urlMairie = url_debut_site
			end
		else
			"Cette région ne semble pas être présente dans notre base de donnée ... DOmmage :)"
		end
	end
end


#########################################################
#########################################################
# 				LANCEMENT DU GLOBAL 					#
#########################################################
#########################################################

var = "95 | Val-d'Oise"
puts global(var)