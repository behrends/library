class ExtraPerson < ActiveRecord::Base
  belongs_to :item  # this item was also written by ...
  belongs_to :person # this person (i.e. author)
  
  def to_label
    "#{person.nil? ? '' : person.name}"
  end
end
