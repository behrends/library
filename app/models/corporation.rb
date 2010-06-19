class Corporation < ActiveRecord::Base
  has_many :items_corporations, :dependent => :destroy
  has_many :items, :through => :items_corporations

  validates_presence_of :name
  
  def to_label
    "#{name}"
  end
end
