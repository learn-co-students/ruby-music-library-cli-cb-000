class MusicLibraryController

	attr_accessor :songs

	def initialize(path='./db/mp3s')
		importer = MusicImporter.new(path)
		@songs = importer.import
	end

	def call
		while 2 + 2 == 4
			input = gets.strip
			case input
			when 'list songs' then Song.print_with_index
			when 'list artists' then Artist.print_all
			when 'list genres' then Genre.print_all
			when 'play song'
				song = Song.all[gets.strip.to_i - 1]
				puts "Playing #{Song.print_song(song)}"
			when 'list artist'
				artist = gets.strip
				songs = Song.all.select { |obj| obj.artist.name == artist }
				songs.each { |song| puts Song.print_song(song) }
			when 'list genre'
				genre = gets.strip
				songs = Song.all.select { |obj| obj.genre.name == genre }
				songs.each { |song| puts Song.print_song(song) }
			when 'exit' then break
			end
		end
	end

end