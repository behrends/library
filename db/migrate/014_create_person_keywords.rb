class CreatePersonKeywords < ActiveRecord::Migration
  def self.up
    create_table :person_keywords do |t|
    end
  end

  def self.down
    drop_table :person_keywords
  end
end
