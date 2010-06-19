class CreateItemsSeries < ActiveRecord::Migration
  def self.up
    create_table :items_series do |t|
    end
  end

  def self.down
    drop_table :items_series
  end
end
