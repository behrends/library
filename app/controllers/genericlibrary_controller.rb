class GenericlibraryController < ApplicationController

  protected

  @@library_location = 3
    
  # return all approved items in EC library sorted by title
  def index
    if !params[:search].blank?
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
        WHERE library_location_id=#{@@library_location} AND is_approved=true AND 
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
      query += " ORDER BY title_main_245a"
      @books = Item.paginate_by_sql([].push(query) + cond, :per_page => 6, :page => params[:page])
    elsif !params[:keywords].blank?
      query =   "(SELECT DISTINCT items.* FROM items 
          LEFT OUTER JOIN items_library_locations ON items.id=items_library_locations.item_id          
          LEFT OUTER JOIN items_keywords ON items.id=items_keywords.item_id          
          LEFT OUTER JOIN keywords ON items_keywords.keyword_id=keywords.id  
          WHERE library_location_id=#{@@library_location} AND is_approved=true AND uniform_title_id IS NULL
          AND keywords.keyword IN (?)) 
          UNION 
          (SELECT DISTINCT items.* FROM items 
          LEFT OUTER JOIN items_library_locations ON items.id=items_library_locations.item_id          
          LEFT OUTER JOIN items_keywords ON items.id=items_keywords.item_id          
          LEFT OUTER JOIN keywords ON items_keywords.keyword_id=keywords.id  
          LEFT OUTER JOIN language041as ON language041as.item_id=items.id
          WHERE library_location_id=3 AND is_approved=true AND uniform_title_id IS NOT NULL
          AND keywords.keyword IN (?) 
          GROUP BY uniform_title_id,language_code_id)"
      @books = Item.paginate_by_sql([query, params[:keywords], params[:keywords]], :per_page => 6, :page => params[:page])     
    else
      query = "SELECT DISTINCT items.* FROM items LEFT OUTER JOIN items_library_locations ON items.id=items_library_locations.item_id 
        WHERE library_location_id=#{@@library_location} AND is_approved=true ORDER BY title_main_245a"
      @books = Item.paginate_by_sql([query], :per_page => 6, :page => params[:page])
    end
    respond_to do |format|
      format.html { render :template => "genericlibrary/index" }
      format.js { render :template => "genericlibrary/index", :layout => false }
    end
  end

  #used by book lightbox
  def book
    return index if !params[:id]
    @book = Item.find(params[:id])
    render(:partial => "genericlibrary/book_details", :locals => { :lib => @@library_location })
  end
  
end
