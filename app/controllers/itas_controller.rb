class ItasController < ApplicationController
  layout "itas"

  # return random approved items in ITAS and online librarys having a cover image
  def index
    query = "SELECT items.* FROM (SELECT items.id FROM items LEFT OUTER JOIN items_library_locations
      ON items.id=items_library_locations.item_id WHERE library_location_id IN (1,4,5) AND is_approved=true 
      AND image_url IS NOT NULL ORDER BY RAND() LIMIT 5) AS random_items JOIN items ON items.id = random_items.id"
    @books = Item.find_by_sql([query])
  end

  # return all approved items in ITAS and online librarys sorted by title
  def all
    query = "SELECT items.* FROM items LEFT OUTER JOIN items_library_locations ON items.id=items_library_locations.item_id 
      WHERE library_location_id IN (1,4,5) AND is_approved=true ORDER BY title_main_245a"
    @books = Item.paginate_by_sql([query], :per_page => 5, :page => params[:page])
  end
  
  def book
    return index if !params[:id]
    @book = Item.find(params[:id])
  end
  
  def book_item
    @book = Item.find(params[:id])
    render(:partial => "book_details", :object => @book, :locals => { :hide_button => false }) if params[:more]
    render(:partial => "book_without_table_row", :object => @book) if params[:less]
  end

  def toggle_search
    render(:partial => "advanced_search") if params[:advanced]
    render(:partial => "simple_search") if params[:simple]
  end

  def search    
    query = "SELECT DISTINCT items.* FROM items 
      LEFT OUTER JOIN people ON people.id = items.person_id 
      LEFT OUTER JOIN items_keywords ON (items.id = items_keywords.item_id) 
      LEFT OUTER JOIN keywords ON (keywords.id = items_keywords.keyword_id) 
      LEFT OUTER JOIN notes ON notes.item_id = items.id 
      LEFT OUTER JOIN items_people_extra_names ON items_people_extra_names.item_id = items.id 
      LEFT OUTER JOIN extra_people ON (items.id = extra_people.item_id) 
      LEFT OUTER JOIN people peoples_items ON (peoples_items.id = extra_people.person_id) 
      LEFT OUTER JOIN uniform_titles ON uniform_titles.id = items.uniform_title_id 
      LEFT OUTER JOIN items_library_locations ON (items.id = items_library_locations.item_id) 
      LEFT OUTER JOIN library_locations ON (library_locations.id = items_library_locations.library_location_id)
      LEFT OUTER JOIN items_person_keywords ipk ON items.id=ipk.item_id
      LEFT OUTER JOIN person_keywords pk ON ipk.person_keyword_id=pk.id
      LEFT OUTER JOIN items_series ON items.id=items_series.item_id
      LEFT OUTER JOIN series ON (series.id = items_series.series_id)
      WHERE library_location_id IN (1,4,5) AND is_approved=true AND 
        (LOWER(items.accession_no) LIKE ? OR LOWER(items.add_titles_700t) LIKE ? OR 
        LOWER(items.audio_url) LIKE ? OR LOWER(items.colophon_505g) LIKE ? OR 
        LOWER(items.content_url) LIKE ? OR LOWER(items.contents_505a) LIKE ? OR 
        LOWER(items.control_field_008) LIKE ? OR LOWER(items.ebook_url) LIKE ? OR 
        LOWER(items.edition_250a) LIKE ? OR LOWER(items.edition_remainder_250b) LIKE ? OR 
        LOWER(items.image_url) LIKE ? OR LOWER(items.isbn_020a) LIKE ? OR 
        LOWER(items.isbn_020a_2) LIKE ? OR LOWER(items.isbn_invalid_020z) LIKE ? OR 
        LOWER(items.issn_022) LIKE ? OR LOWER(items.material_type_006) LIKE ? OR 
        LOWER(items.note_bibliography_504a) LIKE ? OR LOWER(items.note_thesis_502a) LIKE ? OR  
        LOWER(items.physical_details_300b) LIKE ? OR LOWER(items.physical_dimensions_300c) LIKE ? OR 
        LOWER(items.physical_extent_300a) LIKE ? OR LOWER(items.physical_linesperpage_300e) LIKE ? OR 
        LOWER(items.physical_typeofunit_300f) LIKE ? OR LOWER(items.pub_type_007) LIKE ? OR 
        LOWER(items.publication_date_260c) LIKE ? OR LOWER(items.systemcondition_538a) LIKE ? OR 
        LOWER(items.text_beginning_520a) LIKE ? OR LOWER(items.title_main_245a) LIKE ? OR 
        LOWER(items.title_material_desc_245h) LIKE ? OR LOWER(items.title_name_part_245p) LIKE ? OR 
        LOWER(items.title_number_part_245n) LIKE ? OR LOWER(items.title_other_author_245j) LIKE ? OR 
        LOWER(items.title_other_lang_245d) LIKE ? OR LOWER(items.title_remainder_245b) LIKE ? OR 
        LOWER(items.title_responsibility_245c) LIKE ? OR LOWER(items.video_url) LIKE ? OR
        LOWER(people.name) LIKE ? OR LOWER(people.title_100c) LIKE ? OR LOWER(people.fullname_100q) LIKE ? OR 
        LOWER(keywords.keyword) LIKE ? OR LOWER(notes.notes_500a) LIKE ? OR 
        LOWER(items_people_extra_names.alternative_name_400a) LIKE ? OR LOWER(peoples_items.name) LIKE ? OR
        LOWER(peoples_items.title_100c) LIKE ? OR LOWER(peoples_items.fullname_100q) LIKE ? OR
        LOWER(uniform_titles.uniformtitle_240a) LIKE ? OR LOWER(pk.keyword) LIKE ? OR
        LOWER(items_library_locations.shelfmark) LIKE ? OR LOWER(series.name) LIKE ?)"
    cond = ["%" + params[:search].downcase.strip + "%"] * 49
    if params[:has_pdf]
      query += " AND pdf IS NOT NULL"
    end
    query += " ORDER BY title_main_245a"
    @books = Item.paginate_by_sql([].push(query) + cond, :per_page => 5, :page => params[:page])
  end
  
  def advanced_search
    join, query = "", ""
    cond = []
    if !params[:author].nil? && params[:author].length > 0
      # people table
      join += " LEFT OUTER JOIN people p ON items.person_id=p.id"
      query += " AND (LOWER(p.name) LIKE ? OR LOWER(p.title_100c) LIKE ? OR LOWER(p.fullname_100q) LIKE ?"
      # extra_people table
      join += " LEFT OUTER JOIN extra_people ep ON items.id=ep.item_id LEFT OUTER JOIN people p2 ON ep.person_id=p2.id"
      query += " OR LOWER(p2.name) LIKE ? OR LOWER(p2.title_100c) LIKE ? OR LOWER(p2.fullname_100q) LIKE ?"
      # people_extra_names table
      join += " LEFT OUTER JOIN people_extra_names pen ON p.id=pen.person_id"
      query += " OR LOWER(pen.alternative_name_400a) LIKE ?)"
      # parameters for query      
      cond = ["%" + params[:author].downcase.strip + "%"] * 7
    end
    if !params[:title].nil? && params[:title].length > 0
      join += " LEFT OUTER JOIN uniform_titles u ON items.uniform_title_id=u.id"
      query += " AND (LOWER(title_main_245a) LIKE ? OR LOWER(title_other_lang_245d) LIKE ? OR LOWER(u.uniformtitle_240a) LIKE ?) "
      3.times { cond << ("%" + params[:title].downcase.strip + "%") }
    end
    if !params[:keyword].nil? && params[:keyword].length > 0
      join += " LEFT OUTER JOIN items_keywords ik ON items.id=ik.item_id 
        LEFT OUTER JOIN keywords k ON ik.keyword_id=k.id
        LEFT OUTER JOIN items_person_keywords ipk ON items.id=ipk.item_id
        LEFT OUTER JOIN person_keywords pk ON ipk.person_keyword_id=pk.id"
      query += " AND (LOWER(k.keyword) LIKE ? OR LOWER(pk.keyword) LIKE ?)"
      2.times { cond << ("%" + params[:keyword].downcase.strip + "%") }
    end
    if !params[:isbn].nil? && params[:isbn].length > 0
      query += " AND LOWER(isbn_020a) LIKE ?"
      cond.push("%" + params[:isbn].downcase.strip + "%")
    end
    if !params[:shelfmark].nil? && params[:shelfmark].length > 0
      query += " AND LOWER(shelfmark) LIKE ?"
      cond.push("%" + params[:shelfmark].downcase.strip + "%")
    end
    if params[:has_pdf]
      query += " AND pdf IS NOT NULL"
    end
    query = "SELECT DISTINCT items.* FROM items LEFT OUTER JOIN items_library_locations 
      ON items.id=items_library_locations.item_id" + join + " WHERE library_location_id IN (1,4,5)
      AND is_approved=true " + query
    if params[:order] == 'random'
      # query returning items in randomized order
      query = "SELECT items.* FROM  (" + query + " ORDER BY RAND()) AS random_items JOIN items ON items.ID = random_items.ID"
    else
      # in case a switch to the list of items in title order is needed, this would be the regular query 
      query << " ORDER BY title_main_245a"
    end
    @books = Item.paginate_by_sql([].push(query) + cond, :per_page => 5, :page => params[:page])
  
    # use the advanced layout to retain the advanced search form
    render(:template => "itas/advanced_search", :layout => "itas_advanced")
  end
  
  def send_pdf
      send_file "/proj/rails/itas/public/pdfs/" + params[:file], :type=>"application/pdf", :x_sendfile=>true
  end
end
