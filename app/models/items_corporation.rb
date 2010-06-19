class ItemsCorporation < ActiveRecord::Base
  belongs_to :item  
  belongs_to :corporation
  
  def to_label
    "#{corporation.name}"
  end
end
