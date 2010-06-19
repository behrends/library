class CreateUniformTitles < ActiveRecord::Migration
  def self.up
    create_table :uniform_titles do |t|
    end
  end

  def self.down
    drop_table :uniform_titles
  end
end
