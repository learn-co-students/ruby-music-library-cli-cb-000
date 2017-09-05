class MusicLibraryController
	attr_accessor :filepath

	def initialize(filepath = './db/mp3s')
		@filepath = filepath
		@music_importer = MusicImporter.new(@filepath)
		@music_importer.import
	end

	def call
		puts "Welcome to your music library!"
		list_songs = "To list all of your songs, enter 'list songs'."
		list_artists = "To list all of the artists in your library, enter 'list artists'."
		list_genres = "To list all of the genres in your library, enter 'list genres'."
		list_songs_by_artist = "To list all of the songs by a particular artist, enter 'list artist'."
		list_particular_songs_by_genre = "To list all of the songs of a particular genre, enter 'list genre'." 
		play_song = "To play a song, enter 'play song'."
		quit = "To quit, type 'exit'."
		user_choice = "What would you like to do?"

		$stdout.puts(list_songs) 
				$stdout.puts(list_artists)
				$stdout.puts(list_genres)
				$stdout.puts(list_songs_by_artist)
				$stdout.puts(list_particular_songs_by_genre) 
				$stdout.puts(play_song)
				$stdout.puts(quit)
				$stdout.puts(user_choice)
		@input = gets.chomp
			
		case @input
			when "list songs"
				self.list_songs
			when 'list artists'
					self.list_artists
			when 'list genres'
					self.list_genres
			when 'list artist'
					self.list_songs_by_artist
			when 'list genre'
					self.list_songs_by_genre
			when 'play song'
					self.play_song
			else 
					"Please enter a command"
			end 

		while @input != "exit"
				$stdout.puts(list_songs) 
				$stdout.puts(list_artists)
				$stdout.puts(list_genres)
				$stdout.puts(list_songs_by_artist)
				$stdout.puts(list_particular_songs_by_genre) 
				$stdout.puts(play_song)
				$stdout.puts(quit)
				$stdout.puts(user_choice)
				@input = gets.chomp
		end
	end

	def sort_songs
		counter = 0
		@song_names = []
		@trial_run = []
		@music_importer.files.each do |song|
					@song = song.sub(".mp3", "")
					@trial_run << @song
		end
		@trial_run.sort_by! do |song|
			parts = song.split(" - ")
			song_name = parts[1]
			song_name[0]
			@song_names << song_name
			counter += 1
		end
		@song_names.sort_by! do |song_name|
			song_name.split(" - ")[1]
		end 
		@song_names.sort_by! do |song|
			song
		end 
		@song_names
	end 

	def list_songs
		self.sort_songs
			song_counter = 1
			@song_names.each do |song|
				song = Song.find_by_name(song)
				$stdout.puts("#{song_counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}")
				song_counter += 1
			end
	end

	def de_mp3_files
		@trial_run = []
		@music_importer.files.each do |song|
				@song = song.sub(".mp3", "")
				@trial_run << @song
		end
	end 

	def sort_artists
		@artist_names = Artist.all.sort_by! do |artist|
			artist.name
		end 
		@artist_names = @artist_names.uniq
		@artist_names
	end

	def list_artists
		self.sort_artists
		counter = 1
		@artist_names.each do |artist|
			$stdout.puts("#{counter}. #{artist.name}")
			counter += 1
		end
	end

	def sort_genres
		counter = 0
		@genre_names = []
		@trial_run = []
		@music_importer.files.each do |song|
				@song = song.sub(".mp3", "")
				@trial_run << @song
		end
		@trial_run.sort_by! do |parts|
			parts = parts.split(" - ")
			genre = parts[2]
			genre[0]
			@genre_names << genre
			counter += 1
		end
		@genre_names.sort_by! do |genre|
			genre
		end 
		@genre_names = @genre_names.uniq
		@genre_names
	end 

	def list_genres
		self.sort_genres
		counter = 1
		@genre_names.each do |genre|
			genre = Genre.find_by_name(genre)
			$stdout.puts("#{counter}. #{genre.name}")
			counter += 1
		end
	end

	def list_songs_by_artist
		$stdout.puts("Please enter the name of an artist:")
		artist = gets.chomp
		counter = 1
		if Artist.find_by_name(artist) != nil
			artist = Artist.find_by_name(artist)	
			@sorted_songs = artist.songs.sort_by! {|song| song.name}
			@corresponding_genre = artist.genres.each {|genre| genre}
			#use a hash, store the artist's song as the key after alphabetized list generated
			#value is the genre attached to that particular song
			counter = 0
			@sorted_songs.each do |song|
				$stdout.puts("#{counter+1}. #{song.name} - #{@corresponding_genre[counter].name}")
				counter += 1
			end
		end
	end

	def list_songs_by_genre
		$stdout.puts("Please enter the name of a genre:")
		genre = gets.chomp
		counter = 1
		if Genre.find_by_name(genre) != nil
			genre = Genre.find_by_name(genre)	
			@sorted_songs = genre.songs.sort_by! {|song| song.name}
			@corresponding_genre = genre
			#use a hash, store the artist's song as the key after alphabetized list generated
			#value is the genre attached to that particular song
			counter = 0
			@sorted_songs.each do |song|
				$stdout.puts("#{counter+1}. #{@corresponding_genre.artists[counter].name} - #{song.name}")
				counter += 1
			end
		end
	end

	def play_song
		$stdout.puts("Which song number would you like to play?")
		song = gets.chomp
		song = song.to_i
		# custom constructor for .list_songs
		self.sort_songs
		@songs = {}
		song_counter = 1
		@song_names.each do |song|
				song = Song.find_by_name(song)
				@songs[song_counter] = song
				song_counter += 1
		end
		if @songs[song] != nil
			$stdout.puts("Playing #{@songs[song].name} by #{@songs[song].artist.name}")
		end
	end
end
