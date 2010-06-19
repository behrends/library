class LibraryLocation < ActiveRecord::Base
  has_many :items_library_locations
  has_many :items, :through => :items_library_locations
end
