module ItemHelper
  def is_approved_form_column(record, input_name)
    check_box :record, :is_approved, :name => input_name
  end
  
  def is_approved_column(record)
    record[:is_approved] ? "yes" : "no"
  end
  
  def is_rarity_form_column(record, input_name)
    check_box :record, :is_rarity, :name => input_name
  end
  
  def is_rarity_column(record)
    record[:is_rarity] ? "yes" : "no"
  end
end
