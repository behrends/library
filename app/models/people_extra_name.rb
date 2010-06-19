class PeopleExtraName < ActiveRecord::Base
  belongs_to :person

  has_and_belongs_to_many :items, :join_table => "items_people_extra_names", 
                          :delete_sql => "SELECT * FROM users" #dummy statement, can't delete from view

  def to_label
    "#{alternative_name_400a}"
  end
end
