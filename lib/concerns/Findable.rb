module Concerns::Findable
	def find_by_name(name)
		@found = []
		if name == nil
			return "Error:could not find song"
		elsif name != nil
			self.all.find do |instance|
				if instance.name == name
					@found << instance
					@found.first
				end
			end
		end
	end

	def find_or_create_by_name(name)
		self.find_by_name(name)
		if name != nil && @found == nil
			new_song = Song.new(name)
			new_song.save
			new_song
		elsif @found[0] != nil 
			@found[0]
		elsif @found.length == 0
			self.create(name)
		end
	end
end