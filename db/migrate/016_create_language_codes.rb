class CreateLanguageCodes < ActiveRecord::Migration
  def self.up
    create_table :language_codes do |t|
    end
  end

  def self.down
    drop_table :language_codes
  end
end
