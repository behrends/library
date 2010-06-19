class CreateItemsCorporations < ActiveRecord::Migration
  def self.up
    create_table :items_corporations do |t|
    end
  end

  def self.down
    drop_table :items_corporations
  end
end
