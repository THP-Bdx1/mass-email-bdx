require_relative '../app/townhalls_adder_to_db.rb'
require_relative '../app/townhalls_follower.rb'
require_relative '../app/townhalls_mailer.rb'
require_relative '../app/townhalls_scrapper.rb'

class Index
  attr_accessor :mail, :mailing, :handletwitter, :followtwitter, :showdoc
  def perform
    @scrap = false
    @mailing = false
    @handletwitter = false
    @followtwitter = false
    @showdoc = false
    puts "Bienvenue dans ce programme d'envoi automatique de mails envers différentes mairies."
    puts
    puts "Veuillez choisir les fonctions à utiliser :"
    puts
    puts " * Voulez-vous récupérer les adresses mail des mairies de la Gironde [33], des Pyrénées-atlantiques [64], et des Landes [40] ? [Y/N]"
    if checkifyes == true
      @scrap = true
      puts " * Voulez-vous envoyer un mail à chacune des mairies ? [Y/N]"
      @mailing = checkifyes
      puts " * Voulez-vous chercher leur handlebar twitter ? [Y/N]"
      if checkifyes == true
        @handletwitter = true
        puts " * Voulez-vous follow chaque mairie ? [Y/N]"
        @followtwitter = checkifyes
      end
      puts " * Voulez-vous afficher toutes les données ? [Y/N]"
      @showdoc = checkifyes
    end

    if @scrap == true
      puts "Scrapping..."
      Scrapper.new
    end
    if @mailing == true
      puts "Mailing"
      Mailing.new.perform
    end
    Handle.new.perform if @handletwitter == true
    Follow.new.perform if @followtwitter == true
    puts File.read('db/townhalls.json') if @showdoc == true
    puts
    puts "Merci d'avoir utilisé notre programme !"
  end

  def checkifyes
    print ">"
    rep = gets.chomp.capitalize
    puts
    if rep == "Y"
      return true
    elsif rep == "N"
      return false
    else
      puts "Entrée invalide, réessayez."
      checkifyes
    end
  end
end
