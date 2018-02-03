# SONG, ARTIST, AND GENRE BASICS
  # accept a name upon initialization and set that property correctly
  # The name property should be readable and writable by the object

  # each class should contain a class variable @@all that is set to an empty array and is prepared to store all saved instances of the class
  # This class variable should be accessible via the class method .all
  # Instances should respond to a #save method that adds the instance itself into the appropriate @@all class variable
  # The class should be able to empty its @@all array via a class method .destroy_all
  # all classes should implement a custom constructor .create that instantiates an instance using .new but also invokes #save on that instance, forcing it to persist immediately
