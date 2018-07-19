
require 'rubygems'
require 'nokogiri'
require 'open-uri'

class Scrapping
 
def get_the_email_of_a_townhal_from_its_webpage(url)
    page = Nokogiri::HTML(open(url))
    
	return   page.css('td')[7].text
     
end
def get_the_CP_of_a_townhal_from_its_webpage(url)
    page = Nokogiri::HTML(open(url))
 
	return   page.css('td')[11].text
end

def get_all_the_urls_of_morbihan_townhalls(page_url)

page = Nokogiri::HTML(open(page_url))
ville = page.css('p>a').map {|ville| ville.text

}
 link = page.css('p>a').map {|vill| vill['href']} 
return [ville,link]

end




def annuaire_mail_ville(page_url)
	@hash = []
	i=0
	
array = get_all_the_urls_of_morbihan_townhalls(page_url)
	@villes=array[0]
	@cp=array[1].map{ |url|
	get_the_CP_of_a_townhal_from_its_webpage("http://www.annuaire-des-mairies.com/#{url}")}
	@email = array[1].map{ |url|
	get_the_email_of_a_townhal_from_its_webpage("http://www.annuaire-des-mairies.com/#{url}")}
	@villes.length.times do
		@hash += [{ "name" => @villes[i], "email" => @email[i], "cp" => @cp[i]}] 
		i += 1
	end
	return @hash
	end

end
var=Scrapping.new
morbihan=Scrapping.new
lozere=Scrapping.new
puts var.annuaire_mail_ville("http://www.annuaire-des-mairies.com/var.html")
puts morbihan.annuaire_mail_ville("http://www.annuaire-des-mairies.com/morbihan.html")
puts lozere.annuaire_mail_ville("http://www.annuaire-des-mairies.com/lozere.html")