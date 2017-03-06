module Nameable
  def create(name)
    self.new(name).tap {|x| x.save}
  end
end
