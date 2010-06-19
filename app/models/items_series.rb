class ItemsSeries < ActiveRecord::Base
  belongs_to :item  
  belongs_to :series
  
  def to_label
    "#{series.name}"
  end
end
