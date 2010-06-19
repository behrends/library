class CreateLibraryLocations < ActiveRecord::Migration
  def self.up
    create_table :library_locations do |t|
    end
  end

  def self.down
    drop_table :library_locations
  end
end
