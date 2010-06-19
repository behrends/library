class PersonKeyword < ActiveRecord::Base
  has_many :items_person_keywords, :dependent => :destroy
  has_many :items, :through => :items_person_keywords
  
  def to_label
    "#{keyword}"
  end
end
