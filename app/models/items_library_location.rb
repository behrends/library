class ItemsLibraryLocation < ActiveRecord::Base
  belongs_to :item
  belongs_to :library_location
  
  validates_numericality_of :copies, :only_integer => true, :message => "must be an integer."
  
#  validates_associated :item, :library_location
  
#  validates_presence_of :item, :library_location
  
  def to_label
    label = "#{library_location.name} - #{shelfmark} - #{is_approved ? "" : "not"} approved"
    label << " - #{copies} copies" if copies 
    return label
  end
end
