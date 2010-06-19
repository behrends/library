class CreateCorporations < ActiveRecord::Migration
  def self.up
    create_table :corporations do |t|
    end
  end

  def self.down
    drop_table :corporations
  end
end
