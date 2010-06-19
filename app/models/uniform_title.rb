class UniformTitle < ActiveRecord::Base
  has_many :items
  
  validates_presence_of :uniformtitle_240a
  
  def to_label
    "#{uniformtitle_240a}"[0..74]
  end
end
