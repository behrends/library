module CityHelper
  def country_form_column(record, input_name)
    country_select :record, :country
  end
end
