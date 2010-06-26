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

  def export_to_xls(items, library_id)
    file = '/tmp/export-items.xls'
    
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet
    sheet1.row(0).concat %w{Shelfmark Author Title245a Publisher Series }
    
    rowNum = 1
    items.each do |item|
      for library in item.items_library_locations
        if library.library_location.id == library_id
          sheet1.row(rowNum).insert( 0, library.shelfmark ) unless library.shelfmark.nil?
        end
      end
      sheet1.row(rowNum).insert( 1, item.person.to_label ) unless item.person.nil?
      sheet1.row(rowNum).insert( 2, item.title_main_245a ) unless item.title_main_245a.nil?
      sheet1.row(rowNum).insert( 3, item.publisher.to_label ) unless item.publisher.nil?
      all_series = ""
      for series in item.items_series
        all_series << series.series.name unless series.series.nil?
        all_series << "\n" unless series == item.items_series.last
      end
      sheet1.row(rowNum).insert( 4, all_series )
  
      rowNum += 1
    end

    book.write file

    return file
  end
end
