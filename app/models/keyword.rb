class Keyword < ActiveRecord::Base
  has_many :items_keywords, :dependent => :destroy
  has_many :items, :through => :items_keywords
    
  validates_presence_of :keyword

  def to_label
    "#{keyword}"
  end
end
