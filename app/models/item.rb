class Item < ActiveRecord::Base
  belongs_to :person
  belongs_to :city
  belongs_to :uniform_title
  belongs_to :publisher
  belongs_to :journal
  belongs_to :user
  belongs_to :update_user, :class_name=>'User', :foreign_key=>'fk_changed_user'
  
  has_many :varying_title, :dependent => :destroy
  has_many :notes, :dependent => :destroy

  has_many :items_series, :dependent => :destroy
  has_many :series, :through => :items_series
  
  has_many :items_corporations, :dependent => :destroy
  has_many :corporations, :through => :items_corporations
  
  has_many :items_keywords, :dependent => :destroy
  has_many :keywords, :through => :items_keywords
  
  has_many :items_person_keywords, :dependent => :destroy
  has_many :person_keywords, :through => :items_person_keywords

  has_many :items_library_locations, :dependent => :destroy
  has_many :library_locations, :through => :items_library_locations
  
  has_many :language041as, :dependent => :destroy
  has_many :language_codes, :through => :language041as
  
  has_many :language041hs, :dependent => :destroy
  has_many :language_codes, :through => :language041hs

  has_and_belongs_to_many :people_extra_names, 
    :join_table => "items_people_extra_names", #this is a view!
    :delete_sql => "SELECT * FROM users" #dummy statement, can't delete from view
    
  has_many :handwrite_authors, :dependent => :destroy
  has_many :people, :through => :handwrite_authors
  
  has_many :extra_people, :dependent => :destroy
  has_many :people, :through => :extra_people
  
  validates_presence_of :title_main_245a
    
  def to_label
    "#{title_main_245a}"
  end
  
  def image_url
    read_attribute(:image_url).nil? ? "itas-book.gif" : read_attribute(:image_url)
  end
  
  def approved
    items_library_locations.each do |ill|
      return "no" unless ill.is_approved
    end
    return "yes"
  end
end
