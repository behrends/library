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

  def export_to_xls(items)
    file = '/tmp/export-items.xls'
    output_columns = [:title_main_245a, :person]

    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet
    sheet1.row(0).concat %w{Title245a Author}
    
    rowNum = 1
    items.each do |item|
      colNum = 0
      output_columns.each do |col|
        sheet1.row(rowNum).insert( colNum, item.send(col) )
        colNum += 1
      end
      rowNum += 1
    end

    book.write file

    return file
  end
end
