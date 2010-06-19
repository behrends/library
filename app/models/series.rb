class Series < ActiveRecord::Base
  has_many :items_series, :dependent => :destroy
  has_many :items, :through => :items_series

  validates_presence_of :name

  def to_label
    "#{name}"[0..74]
  end
end
