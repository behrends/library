class CreateSeries < ActiveRecord::Migration
  def self.up
    create_table :series do |t|
    end
  end

  def self.down
    drop_table :series
  end
end
