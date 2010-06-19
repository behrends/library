class Journal < ActiveRecord::Base
  has_many :items
  
  validates_presence_of :name
  
  def to_label
    "#{name}"
  end
end
