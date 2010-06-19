class CreateItemsPersonKeywords < ActiveRecord::Migration
  def self.up
    create_table :items_person_keywords do |t|
    end
  end

  def self.down
    drop_table :items_person_keywords
  end
end
