class VaryingTitle < ActiveRecord::Base
  belongs_to :item

  validates_presence_of :title_varying_246a

  def to_label
    "#{title_varying_246a}"
  end
end
