class CreateItemsLibraryLocations < ActiveRecord::Migration
  def self.up
    create_table :items_library_locations do |t|
    end
  end

  def self.down
    drop_table :items_library_locations
  end
end
