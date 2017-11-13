module Concerns::Sortable
  include Comparable

  def <=>(other)
    self.name <=> other.name
  end

end
