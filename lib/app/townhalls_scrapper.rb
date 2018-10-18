require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'



class Scrapper

    def initialize

        def get_the_email_of_a_townhal_from_its_webpage(url)
            page = Nokogiri::HTML(open(url))     
            a = page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
            return a.text
        end

            page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))   

            mairie_links = page.css("a.lientxt")
    
            array_of_names = []
            array_of_urls = []

            mairie_links.each do |infos|
            array_of_urls << "http://annuaire-des-mairies.com"+ infos['href'][1..-1]
            array_of_names << infos.text
            end

            mail_array = []    
            array_of_urls.each do |url|
            mail_array << get_the_email_of_a_townhal_from_its_webpage(url)
            puts mail_array
            end
    
            final_array = Hash[array_of_names.zip(mail_array)]
            File.write("db/emails.json",final_array.to_json)
       
    end
end