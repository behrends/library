class Note < ActiveRecord::Base
  belongs_to :item
  
  def to_label
    "#{notes_500a}"
  end
end
