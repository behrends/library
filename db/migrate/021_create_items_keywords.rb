class CreateItemsKeywords < ActiveRecord::Migration
  def self.up
    create_table :items_keywords do |t|
    end
  end

  def self.down
    drop_table :items_keywords
  end
end
