require "rubygems" #
require "nokogiri" #
require "open-uri" #
####################

#renvoit lien complet
def donneUrl(lien) 
	debut_site = "http://www2.assemblee-nationale.fr"
	return debut_site+"#{lien}"
end


#renvoit liste contenant : les urls de chaque depute
def get_depute_page
	#------------------------------------------------------
	page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	#------------------------------------------------------
	liste_url_depute = []
	#ENTRER DANS CHAQUE DEPUTES (recupère url)
	var = page.css("div[class='contenu-principal  pleine-largeur clearfix'] li a")
	var.length.times { |i| 
		url = var[i]["href"]
		#crée liste avec adresse complète (devant)
		liste_url_depute.push(donneUrl(url)) 
	}
	return liste_url_depute
end

#prend en parametre : url de la page du depute
#renvoit : hash avec les infos (prenom, nom, email)
def get_nom_prenom_mail(url)
	#------------------------------------------------------
	page = Nokogiri::HTML(open(url))
	#------------------------------------------------------
	#recupere prenom & nom du depute
	nomPrenom = page.css("h1").text
	nomPrenom = nomPrenom.split
	prenom = nomPrenom[1]
	nom = nomPrenom[2]

	#recupere email
	email = page.css("a[class='email']")[0]["href"]

	return {"prenom" => prenom, "nom" => nom, "email" => email}
end

def global
	listeNomPrenomEmail = []
	#recupère liste des url de chaque depute (avec methode get_depute_page)
	liste_depute = get_depute_page
	#recupere les infos sur les deputes et les mettre dans : listeNomPrenomEmail (mettre les hash dans l'array)
	liste_depute.each{|i| listeNomPrenomEmail.push(get_nom_prenom_mail(i)) }

	#TEST RAPIDE SUR 5 DEPUTES
	#5.times {|i| listeNomPrenomEmail.push(get_nom_prenom_mail(liste_depute[i])) }
	return listeNomPrenomEmail
end


#########################################################
#########################################################
# 				LANCEMENT DU GLOBAL 					#
#########################################################
#########################################################
puts global