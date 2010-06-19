class ItemsPersonKeyword < ActiveRecord::Base
  belongs_to :item
  belongs_to :person_keyword
  
  def to_label
    "#{person_keyword.keyword}"
  end
end
