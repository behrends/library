class Language041h < ActiveRecord::Base
  belongs_to :item  # this item is written in ...
  belongs_to :language_code # this language

  validates_inclusion_of :position, :in => 1..9, :message => "must be a digit (1..9)."

  def to_label
    "#{language_code.code}"
  end
end
