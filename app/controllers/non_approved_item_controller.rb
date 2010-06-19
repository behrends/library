class NonApprovedItemController < ItemController  

  def conditions_for_collection
    ['items_library_locations.is_approved = 0 OR items_library_locations.is_approved IS NULL']
  end
  
  def set_page_name
    @pagename = "Items (not approved)"    
  end
end