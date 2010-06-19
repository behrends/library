class CreateExtraPeople < ActiveRecord::Migration
  def self.up
    create_table :extra_people do |t|
    end
  end

  def self.down
    drop_table :extra_people
  end
end
