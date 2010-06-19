class Person < ActiveRecord::Base
  has_many :items
  has_many :people_extra_names
  
  has_many :handwrite_authors, :dependent => :destroy
  has_many :handwritten_items, :through => :handwrite_authors
  
  has_many :extra_people, :dependent => :destroy
  has_many :co_authored_items, :source => "item", :through => :extra_people
    
  validates_presence_of :name

  before_destroy :ensure_not_author_of_items 
  
  def ensure_not_author_of_items
    unless self.items.empty?
       self.errors.add_to_base("Can't delete person who is author of existing items.")
       return false
     end
  end  
  
  def to_label
    "#{name}"
  end
  
  def get_display_name
    display_name.nil? ? (fullname_100q.nil? ? to_label : fullname_100q.to_s) : display_name.to_s
  end
end
