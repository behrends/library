class CreateVaryingTitles < ActiveRecord::Migration
  def self.up
    create_table :varying_titles do |t|
    end
  end

  def self.down
    drop_table :varying_titles
  end
end
