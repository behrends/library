class LanguageCode < ActiveRecord::Base
  has_many :language041as
  has_many :items, :through => :language041as
  
  has_many :language041hs
  has_many :items, :through => :language041hs
    
  def to_label
    "#{code}"
  end
end
