class CreateKibis < ActiveRecord::Migration
  def self.up
    create_table :kibis do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :kibis
  end
end
