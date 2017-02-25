require 'pry'

class MusicLibraryController

	def initialize(path = './db/mp3s')
		importer = MusicImporter.new(path)
		importer.import
	end

	def call
		input = ""
		while input != "exit"
			puts "Welcome to the music libary!"
			puts "How can I help you?"
			input = gets.strip
			case input
			when "list songs"
				songs
			when "list artists"
				artists
			when "list genres"
				genres
			when "list genre"
        		list_genre
        	when "list artist"
        		list_artist
        	when "play song"
				play	
			end
		end
	end

	def songs
		Song.all.each_with_index do |s, i|
			puts "#{(i + 1).to_s}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
		end
	end

	def artists
		Artist.all.each_with_index do |a, i|
			puts "#{(i + 1).to_s}. #{a.name}"
		end
	end

	def genres
		Genre.all.each_with_index do |g, i|
			puts "#{(i + 1).to_s}. #{g.name}"
		end
	end

	def play
		puts "Which one would you like?"
		song_to_play = gets.strip

		puts "Playing #{Song.all[song_to_play.to_i-1].to_string}"
	end

	def list_genre
   		puts "What genre by name you like to list songs for?"
   		genre_choice = gets.strip
	    genre = Genre.find_by_name(genre_choice)
	        genre.songs.each do |song, index|
	        puts "#{song.to_string}"
	    end
	end

	def list_artist
		puts "Which artist?"
		artist_choice = gets.strip
		artist = Artist.find_by_name(artist_choice)
			artist.songs.each do |song|
		    puts "#{song.to_string}"
		end
	end

end