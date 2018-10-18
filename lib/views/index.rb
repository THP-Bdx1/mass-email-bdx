$:.unshift File.expand_path("../../app", __FILE__)
require 'townhalls_adder_to_db.rb'
require 'townhalls_follower.rb'
require 'townhalls_mailer.rb'
require 'townhalls_scrapper.rb'

class Index
  attr_accessor :mail, :mailer, :handletwitter, :followtwitter, :showdoc
  def perform
    @scrap = false
    @mailer = false
    @handletwitter = false
    @followtwitter = false
    @showdoc = false
    puts "Bienvenue dans ce programme d'envoi automatique de mails envers differentes mairies."
    puts
    puts "Veuillez choisir les fonctions a utiliser"
    puts
    puts " * Voulez vous recuperer les adresse mail des maire de la Gironde [33], les Pyrénées-atlantiques [64], et les Landes [40]. [Y/N]"
    if checkifyes == true
      @scrap = true
      puts " * Voulez vous envoyer un mail un chacune des mairies ? [Y/N]"
      @mailer = checkifyes
      puts " * Voulez vous chercher leur handlebar twitter ? [Y/N]"
      if checkifyes == true
        @handletwitter = true
        puts " * Voulez vous follow chaque mairie ? [Y/N]"
        @followtwitter = checkifyes
      end
      puts " * Voulez vous afficher toute les données ? [Y/N]"
      @showdoc = checkifyes
    end
    puts "Scrap.new" if @scrap == true
    puts "Mailer.new" if @mailer == true
    puts "Handle.new" if @handletwitter == true
    puts "Follow.new" if @followtwitter == true
    puts File.read('db/townhalls.json') if @showdoc == true
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

Index.new
