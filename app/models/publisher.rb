class Publisher < ActiveRecord::Base
  has_many :items

  validates_presence_of :name

  def to_label
    "#{name}"[0..74]
  end
end
