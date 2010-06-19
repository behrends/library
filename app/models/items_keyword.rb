class ItemsKeyword < ActiveRecord::Base
  belongs_to :item
  belongs_to :keyword
  
  def to_label
    "#{keyword.keyword}"
  end
end
