class HandwriteAuthor < ActiveRecord::Base
  belongs_to :item  # this item has been written by...
  belongs_to :person # this person
  
  def to_label
    result = ""
    result = result + (person.nil? ? "" : "Author: " + "#{person.name}")
    result = result + (place.nil? ? "" : " Place: " + "#{place}")
    result = result + (date.nil? ? "" : " Date: " + "#{date}")
    return result
  end
end
