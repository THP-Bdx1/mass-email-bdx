require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'



class Scrapper

    def initialize
        @@array_of_names = []
        @@array_of_departement = []
        @@array_of_mails = []
        @@array_of_urls = []

        scrapp_city_names_and_region ("https://www.annuaire-administration.com/mairie/departement/pyrenees-atlantiques.html")
        scrapp_city_names_and_region ("https://www.annuaire-administration.com/mairie/departement/gironde.html")
        scrapp_city_names_and_region ("https://www.annuaire-administration.com/mairie/departement/la-reunion.html")
        puts "Loading ..."
            @@array_of_urls.each do |url|
                scrapp_email_from_townpage(url)
            end

        @@array_de_hashs_infos_mairies = []

            compteur = 0
            while compteur < @@array_of_names.length
            hash_temporaire ={"ville"=>@@array_of_names[compteur].capitalize, "mail"=> @@array_of_mails[compteur], "département"=>@@array_of_departement[compteur]}
            @@array_de_hashs_infos_mairies << hash_temporaire
            compteur += 1
            end

            File.open("db/townhalls.json","w") do |f|
              f.write(@@array_de_hashs_infos_mairies.to_json)
            end
    end

    def scrapp_email_from_townpage (url)
        begin
        page = Nokogiri::HTML(open(url))
        rescue
        @@array_of_mails << "bug page"
        else
            css_page = page.css("td.hotelvalue a[href]")
            if css_page.to_s.include?("mailto")
                css_page.each do |a|
                    if a["href"].include?("mailto") == true
                    @@array_of_mails << a.text
                    end
                end

            else
                @@array_of_mails << "Pas de mail ='("
            end
        end
    end


    def scrapp_city_names_and_region (page_departements)
        page_departement = Nokogiri::HTML(open(page_departements))

        mairie_links = page_departement.css("a")

        mairie_links.each do |infos|
            if infos['href'].include?("-64")
                @@array_of_departement << "Pyrénées Atlantiques"
                @@array_of_names << infos['href'][47..-12]
                @@array_of_urls << infos['href']
            end

            if infos['href'].include?("-33")
                @@array_of_departement << "Gironde"
                @@array_of_names << infos['href'][47..-12]
                @@array_of_urls << infos['href']
            end

            if infos['href'].include?("-974")
                @@array_of_departement << "La Réunion"
                @@array_of_names << infos['href'][47..-12]
                @@array_of_urls << infos['href']
            end
        end
    end
end
