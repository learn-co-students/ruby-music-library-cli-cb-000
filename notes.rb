# SONG, ARTIST, AND GENRE BASICS
  # accept a name upon initialization and set that property correctly
  # The name property should be readable and writable by the object

  # each class should contain a class variable @@all that is set to an empty array and is prepared to store all saved instances of the class
  # This class variable should be accessible via the class method .all
  # Instances should respond to a #save method that adds the instance itself into the appropriate @@all class variable
  # The class should be able to empty its @@all array via a class method .destroy_all
  # all classes should implement a custom constructor .create that instantiates an instance using .new but also invokes #save on that instance, forcing it to persist immediately

# RELATIONSHIPS & ASSOCIATIONS
    # Songs & Artists
      # Songs belong to an artist and an artist has many songs
      # Adding a song to an artist is done by calling an #add_song method on an instance of the Artist class
      # Songs can be initialized with an optional artist argument

    # Songs & Genres
      # Genres have many songs and are initialized with an empty list of songs
      # Songs have one genre
      # Songs can be initialized with an optional genre argument

    # Artists & Genres
      # Artists have many genres through their songs
      # Genres have many artists through their songs

=begin
  Notes

  #tap method
  Yields x to the block, and then returns x
  https://apidock.com/ruby/Object/tap

  ----------------------------------------------------------------------------------------

  Ways #tap can be used: http://seejohncode.com/2012/01/02/ruby-tap-that/

  ----------------------------------------------------------------------------------------

  Example from https://www.engineyard.com/blog/five-ruby-methods-you-should-be-using

  Ever find yourself calling a method on some object, and the return value is not what you want it to be? You’re hoping to get back the object, but instead you got back some other value. Maybe you want to add an arbitrary value to a set of parameters stored in a hash, so you update it with Hash.[], but you get back 'bar' instead of the params hash—so you have to return it explicitly.

  def update_params(params)
    params[:foo] = 'bar'
    params
  end

  The params line at the end of that method seems extraneous. So, we can clean it up with Object#tap.

  It’s easy to use. Just call it on the object, then pass tap a block with the code that you wanted to run. The object will be yielded to the block and then be returned. Here’s how we could use it to improve update_params:

  def update_params(params)
    params.tap {|p| p[:foo] = 'bar' }
  end

  There are dozens of great places to use Object#tap. Just keep your eyes open for methods called on an object that don’t return the object, when you wish that they would.



=end
