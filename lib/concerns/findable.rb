module Concerns::Findable

  def find_by_name(name)
    obj=nil
    self.all.detect { |s| obj = s if s.name == name}
    obj
    # self.all.detect { |s| s.name == name}
  end #self.find_by_name

  def find_or_create_by_name(name)
    item = self.find_by_name(name)
    item = self.create(name) if item.nil?
    item
  end #self.find_or_create_by_name

end


#why not self.find_by_name or self.find_or_create_by_name?
#because its a class extension?
#just like you cant use << with a mixin?
  #.  In a standard mixin you can’t use self to refer to the caller.
  #  But with Rails’ concern self becomes as if you are in the class that is/(will be)
  # inheriting this.
  #https://6ftdan.com/allyourdev/2015/02/24/writing-methods-for-both-class-and-instance-levels/
