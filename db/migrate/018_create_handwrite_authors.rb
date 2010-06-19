class CreateHandwriteAuthors < ActiveRecord::Migration
  def self.up
    create_table :handwrite_authors do |t|
    end
  end

  def self.down
    drop_table :handwrite_authors
  end
end
