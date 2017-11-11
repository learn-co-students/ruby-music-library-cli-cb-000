module Concerns::Findable

  def find_by_name(name)
    self.all.detect do |song|
      song.name == name
    end
  end

  def find_or_create_by_name(name)
    find = find_by_name(name)
    if find.instance_of? self
      find
    else
      artist_or_genre_object = self.create(name)
      artist_or_genre_object
    end
  end
end
