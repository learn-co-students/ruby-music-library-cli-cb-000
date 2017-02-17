require 'pry'
class MusicLibraryController
	def initialize(path="./db/mp3s")
		@songs = MusicImporter.new(path).import
		@songs = @songs.sort {|s1,s2|
			res = s1.artist.name <=>s2.artist.name
		} unless @songs==nil
	end

	def call
		while true
			print ">"
			cmd = gets.strip.downcase.split(" ")
			case cmd[0]
			when "exit"
				break;
			when "list"
				list_cmd(cmd[1])
			when "play"
				song_num = gets.strip.to_i
				song = @songs[song_num-1]
				puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
			else
				puts "Unknown Command"
			end
		end
	end

	def list_cmd(item)
		case item
		when "songs"
			@songs.each_with_index do |song, index|
				puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
			end
		when "artists"
			list(Artist.all)
		when "genres"
			list(Genre.all)
		when "artist"
			artist = Artist.find_by_name(gets.strip)
			list_songs(artist.songs)
		when "genre"
			genre = Genre.find_by_name(gets.strip)
			list_songs(genre.songs)
		else
			puts "Can't list #{item}"
		end

	end

	def list_songs(songs)
		songs.each_with_index do |song, index|
			puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
		end
	end

	def list(array)
		array.each do |item|
				puts item.name
		end
	end
end
