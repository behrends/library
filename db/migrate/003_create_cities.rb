class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
    end
  end

  def self.down
    drop_table :cities
  end
end
