class CreateExtraPersonNames < ActiveRecord::Migration
  def self.up
    create_table :extra_person_names do |t|
    end
  end

  def self.down
    drop_table :extra_person_names
  end
end
