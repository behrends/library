class ItemController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  before_filter :set_page_name

  active_scaffold :item do |conf|
    #conf.action_links.add 'duplicate',
    #  :label => "Duplicate",
    #  :type => :record,
    #  :inline => true,
    #  :position => :false

    conf.columns[:people_extra_names].label = "Author names"
    conf.columns[:library_locations].label = "Libraries"

    conf.columns[:isbn_020a].description = "ISBN (International Standard Book Number)"
    conf.columns[:isbn_020a_2].description = "additional/alternative ISBN"
    conf.columns[:isbn_invalid_020z].description = "invalid or incorrect ISBN"
    conf.columns[:issn_022].description = "International Standard Serial Number – only for Journals and serials, you will find the number on the impressum page or on the cover."
    conf.columns[:language041as].description = "Language of the book in front of you - e.g. tib/pli/eng/ger or see under http://lcweb.loc.gov/marc/languages/"
    conf.columns[:language041hs].description = "Language in which the document was written originally - e.g. tib/pli/eng/ger or see under http://lcweb.loc.gov/marc/languages/"
    conf.columns[:title_main_245a].description = "Maintitle appearing on the cover or front page as the chief source of information."
    conf.columns[:title_remainder_245b].description = "Other title information after the main title, see here not only the cover but also the front page."
    conf.columns[:title_responsibility_245c].description = "The name of the author/editor as it appears on the cover. Prolific authors often vary the way they present their names (enter Firstname Lastname)"
    conf.columns[:title_other_lang_245d].description = "Title in any other language, if this title appears in the publication."
    conf.columns[:title_material_desc_245h].description = "Here you indicated the material of the document in front of you (Graphic, Motion Picture, Cartographic Material, Manuscript, Multimedia, Music)."
    conf.columns[:title_other_author_245j].description = "Useful for collected works on one subject with different authors. Here you can add the title of the other authors."
    conf.columns[:title_number_part_245n].description = "Identifying the part/section of an author’s work in the book in front of us – e.g. Series A/B/C or Part 1."
    conf.columns[:title_name_part_245p].description = "Useful for identification of the different parts/sections by name of the part/section of an authors work in the same book."
    conf.columns[:varying_title].description = "Tibetan title/Sanskrit title or a different/varying title appearing on an item / on the cover and the title page in the english version of the book."
    conf.columns[:edition_250a].description = "The edition statement is recorded in abbreviated form in the language in which it appears (impressum page). Only if not the first edition."
    conf.columns[:edition_remainder_250b].description = "You use this field only if it is not the first edition and there is an indication of an author’s/editor's name."
    conf.columns[:city].description = "First place of publication. You will find this information on the impressum page."
    conf.columns[:publisher].description = "Publisher's name. You will find this information on the impressum page."
    conf.columns[:publication_date_260c].description = "The actual year of the publication."
    conf.columns[:physical_extent_300a].description = "Number of pages of the book, e.g. 300 p. You can also add the roman numerals first, e.g. Xii, 300 p."
    conf.columns[:physical_details_300b].description = "All other physical details like photos, drawings, maps, illustrations in an abbreviated form. And all important physical details for the Tibetan pechas."
    conf.columns[:physical_dimensions_300c].description = "If there is any indication as cm, mm or inches. There is no fixed succession."
    conf.columns[:physical_linesperpage_300e].description = "Used especially for the pechas."
    conf.columns[:physical_typeofunit_300f].description = "Used especially for the pechas."
    conf.columns[:notes].description = "This field can be used for any information which is useful and helps, like who made the translation, or who wrote a commentary."
    conf.columns[:note_thesis_502a].description = "If the document in front of you is a thesis, then you fill this field with the information in which University this thesis was written."
    conf.columns[:note_bibliography_504a].description = "Information on the presence of one or more bibliographies and/or other bibliographic references in a described item or in accompanying material."
    conf.columns[:contents_505a].description = "Titles of separate works or parts of an item or the table of contents."
    conf.columns[:colophon_505g].description = "Colophon; miscellaneous information"
    conf.columns[:text_beginning_520a].description = "This could be a summary, abstract, annotation, review, or only a phrase describing the material."
    conf.columns[:systemcondition_538a].description = "Technical information about an item, such as the presence or absence of certain kinds of codes."
    conf.columns[:handwrite_authors].description = "This field is used for Tibetan pechas – the person who wrote the pecha in front of you, always in Wylie."
    conf.columns[:pdf].description = "File name of PDF scan on library database server."
    conf.columns[:content_url].description = "URL link to a summary or content description."
    conf.columns[:image_url].description = "URL link to a thumbnail image for this book."
    conf.columns[:ebook_url].description = "URL link to an online eBook (e.g. Google Books)."
    conf.columns[:audio_url].description = "URL link to a audio recordings in the WWW related to this item."
    conf.columns[:video_url].description = "URL link to a video in the WWW related to this item."
    conf.columns[:is_rarity].description = "Select this check box if this item is a rarity and should not be taken out of the library."

    conf.columns[:person].description = "The name of the author who is primarily responsible for the content of the item. See the front/main page."

    conf.search.columns << :id
    conf.columns[:person].search_sql = "people.name"
    conf.search.columns << :person
    conf.columns[:keywords].search_sql = "keywords.keyword"
    conf.search.columns << :keywords
    conf.columns[:notes].search_sql = "notes.notes_500a"
    conf.search.columns << :notes
    conf.columns[:people_extra_names].search_sql = "people_extra_names.alternative_name_400a"
    conf.search.columns << :people_extra_names
    conf.columns[:extra_people].includes = [:people]
    conf.columns[:extra_people].search_sql = "peoples_items.name"
    conf.search.columns << :extra_people
    conf.columns[:uniform_title].search_sql = "uniform_titles.uniformtitle_240a"
    conf.search.columns << :uniform_title
    conf.columns[:library_locations].search_sql = "items_library_locations.shelfmark"
    conf.search.columns << :library_locations

    #LIST
    conf.list.columns = [:id,:isbn_020a,:title_main_245a,:person, :people_extra_names,
     :extra_people, :keywords,:notes, :library_locations, :is_rarity, :approved]
         conf.list.sorting = {:id => :asc} 

    #SHOW
    conf.show.columns.exclude :items_keywords
    conf.show.columns.exclude :items_corporations
    conf.show.columns.exclude :items_series

    conf.create.link.label = "Add a new item"
    conf.create.columns = []
    conf.update.columns = []
    conf.show.columns = [:id, :isbn_020a, :isbn_020a_2, :isbn_invalid_020z, :issn_022, 
     :language041as, :language041hs, :person, :journal, :uniform_title, 
     :title_main_245a, :title_remainder_245b, :title_remainder_245b_2, :title_responsibility_245c,
     :title_other_lang_245d, :title_material_desc_245h, :title_other_author_245j,
     :title_number_part_245n, :title_name_part_245p, :varying_title, :edition_250a, 
     :edition_remainder_250b, :city, :publisher, :publication_date_260c, 
     :physical_extent_300a, :physical_details_300b, :physical_dimensions_300c,
     :physical_linesperpage_300e, :physical_typeofunit_300f, :items_series, 
     :notes, :note_thesis_502a, :note_bibliography_504a, :contents_505a,
     :colophon_505g, :text_beginning_520a, :systemcondition_538a, :handwrite_authors, 
     :items_keywords, :items_person_keywords, :extra_people, :accession_no, 
     :items_library_locations, :is_rarity, :items_corporations, :pdf, :content_url, :ebook_url,
     :audio_url, :video_url, :user, :created_at, :update_user, :updated_at
    ]

    conf.columns[:user].label = "Created by"
    conf.columns[:update_user].label = "Updated by"

    #Block: Control and code fields
    conf.columns[:isbn_020a].label = "020$a: ISBN"
    conf.columns[:isbn_020a_2].label = "020$a: ISBN 2"
    conf.columns[:isbn_invalid_020z].label = "020$z: ISBN (invalid)"
    conf.columns[:issn_022].label = "022: ISSN"
    conf.columns[:language041as].label = "041$a: Language"
    conf.columns[:language041hs].label = "041$h: Language"

    conf.create.columns.add_subgroup "Control and code fields" do |group|
     group.add :isbn_020a, :isbn_020a_2, :isbn_invalid_020z, :issn_022, :language041as, :language041hs
    end

    conf.update.columns.add_subgroup "Control and code fields" do |group|
     group.add :isbn_020a, :isbn_020a_2, :isbn_invalid_020z, :issn_022, :language041as, :language041hs
    end

    #Block: Main entry
    conf.columns[:person].label = "100$a: Author"

    conf.create.columns.add_subgroup "Main entry" do |group|
     group.add :person
    end

    conf.update.columns.add_subgroup "Main entry" do |group|
     group.add :person
    end

    #Block: Title
    conf.columns[:title_main_245a].label = "245$a: Main title"
    conf.columns[:title_remainder_245b].label = "245$b: Remainder/subtitle"
    conf.columns[:title_remainder_245b_2].label = "245$b: Remainder/subtitle (2)"
    conf.columns[:title_responsibility_245c].label = "245$c: Title responsibility"
    conf.columns[:title_other_lang_245d].label = "245$d: Title in another language"
    conf.columns[:title_material_desc_245h].label = "245$h: General material description"
    conf.columns[:title_other_author_245j].label = "245$j: Title of another author"
    conf.columns[:title_number_part_245n].label = "245$n: Part/section number"
    conf.columns[:title_name_part_245p].label = "245$p: Part/section name"
    conf.columns[:varying_title].label = "246$a: Varying title"


    conf.create.columns.add_subgroup "Title" do |group|
     group.add :title_main_245a, :title_remainder_245b, :title_remainder_245b_2, :title_responsibility_245c, :title_other_lang_245d,
     :title_material_desc_245h, :title_other_author_245j, :title_number_part_245n, :title_name_part_245p, :varying_title
    end

    conf.update.columns.add_subgroup "Title" do |group|
     group.add :title_main_245a, :title_remainder_245b, :title_remainder_245b_2, :title_responsibility_245c, :title_other_lang_245d,
     :title_material_desc_245h, :title_other_author_245j, :title_number_part_245n, :title_name_part_245p, :varying_title
    end

    #Block: Journal
    conf.columns[:journal].label = "222$a: Journal"

    conf.create.columns.add_subgroup "Journal" do |group|
     group.add :journal
    end

    conf.update.columns.add_subgroup "Journal" do |group|
     group.add :journal
    end

    #Block: Uniform title
    conf.columns[:uniform_title].label = "240$a: Uniform title"

    conf.create.columns.add_subgroup "Uniform title" do |group|
     group.add :uniform_title
    end

    conf.update.columns.add_subgroup "Uniform title" do |group|
     group.add :uniform_title
    end

    #Block: Publication Data
    conf.columns[:edition_250a].label = "250$a: Edition statement"
    conf.columns[:edition_remainder_250b].label = "250$b: Edition statement remainder"
    conf.columns[:city].label = "260$a: Place of publication/distribution"
    conf.columns[:publisher].label = "260$b: Name of publisher/distributor"
    conf.columns[:publication_date_260c].label = "260$c: Year of publication"
    conf.columns[:publication_date_260c].form_ui = :calendar 

    conf.create.columns.add_subgroup "Publication data" do |group|
     group.add :edition_250a, :edition_remainder_250b, :city, :publisher, :publication_date_260c
    end

    conf.update.columns.add_subgroup "Publication data" do |group|
     group.add :edition_250a, :edition_remainder_250b, :city, :publisher, :publication_date_260c
    end

    #Block: Physical Description
    conf.columns[:physical_extent_300a].label = "300$a: Physical extent"
    conf.columns[:physical_details_300b].label = "300$b: Physical details"
    conf.columns[:physical_dimensions_300c].label = "300$c: Physical dimensions"
    conf.columns[:physical_linesperpage_300e].label = "300$e: Lines per page"
    conf.columns[:physical_typeofunit_300f].label = "300$f: Type of unit"

    conf.create.columns.add_subgroup "Physical description" do |group|
     group.add :physical_extent_300a, :physical_details_300b, :physical_dimensions_300c,
     :physical_linesperpage_300e, :physical_typeofunit_300f
    end

    conf.update.columns.add_subgroup "Physical description" do |group|
     group.add :physical_extent_300a, :physical_details_300b, :physical_dimensions_300c,
     :physical_linesperpage_300e, :physical_typeofunit_300f
    end

    #Block: Series
    conf.columns[:items_series].label = "490$a: Series statement"

    conf.create.columns.add_subgroup "Series" do |group|
     group.add :items_series
    end

    conf.update.columns.add_subgroup "Series" do |group|
     group.add :items_series
    end

    #Block: Note Fields
    conf.columns[:notes].label = "500$a: Notes"
    conf.columns[:note_thesis_502a].label = "502$a: Thesis notes"
    conf.columns[:note_bibliography_504a].label = "504$a: Bibliographical notes"
    conf.columns[:contents_505a].label = "505$a: Contents"
    conf.columns[:colophon_505g].label = "505$g: Colophon"
    conf.columns[:text_beginning_520a].label = "520a$: Beginning of the text"
    conf.columns[:systemcondition_538a].label = "538$a: System condition"
    conf.columns[:handwrite_authors].label = "Writer of the handwriting"

    conf.create.columns.add_subgroup "Note fields" do |group|
     group.add :notes, :note_thesis_502a, :note_bibliography_504a, :contents_505a,
     :colophon_505g, :text_beginning_520a, :systemcondition_538a, :handwrite_authors
    end

    conf.update.columns.add_subgroup "Note fields" do |group|
     group.add :notes, :note_thesis_502a, :note_bibliography_504a, :contents_505a,
     :colophon_505g, :text_beginning_520a, :systemcondition_538a, :handwrite_authors
    end

    #Block: Subject Access (Keywords)
    conf.columns[:items_keywords].label = "650$a: Keywords"
    conf.columns[:keywords].label = "650$a: Keywords"
    conf.columns[:items_person_keywords].label = "600$a: Keyword Name of the person"

    conf.create.columns.add_subgroup "Subject Access (Keywords)" do |group|
     group.add :items_keywords, :items_person_keywords
    end

    conf.update.columns.add_subgroup "Subject Access (Keywords)" do |group|
     group.add :items_keywords, :items_person_keywords
    end

    #Block: Other people 
    conf.columns[:extra_people].label = "700$a: Other people"

    conf.create.columns.add_subgroup "Other authors involved in this item" do |group|
     group.add :extra_people
    end

    conf.update.columns.add_subgroup "Other authors involved in this item" do |group|
     group.add :extra_people
    end

    #Block: Corporations
    conf.columns[:items_corporations].label = "710$a: Corporation"

    conf.create.columns.add_subgroup "Corporations" do |group|
     group.add :items_corporations
    end

    conf.update.columns.add_subgroup "Corporations" do |group|
     group.add :items_corporations
    end

    #Block: URLs (non-MARC)
    conf.columns[:pdf].label = "PDF scan"
    conf.columns[:content_url].label = "URL content"
    conf.columns[:image_url].label = "URL image"
    conf.columns[:ebook_url].label = "URL ebook"
    conf.columns[:audio_url].label = "URL audio"
    conf.columns[:video_url].label = "URL video"

    conf.create.columns.add_subgroup "URLs (image, ebook, content, audio, video)" do |group|
     group.add :image_url, :content_url, :pdf, :ebook_url, :audio_url, :video_url
    end

    conf.update.columns.add_subgroup "URLs (image, ebook, content, audio, video)" do |group|
     group.add :image_url, :content_url, :pdf, :ebook_url, :audio_url, :video_url
    end

    #Block: Library, Shelfmark, Accession, Rarity (non-MARC)
    conf.columns[:accession_no].label = "Accession No."
    conf.columns[:items_library_locations].label = "Library with shelfmark"
    conf.columns[:is_rarity].label = "Rarity"

    conf.create.columns.add_subgroup "Library, Shelfmark, Accession, Rarity (non-MARC)" do |group|
     group.add :accession_no, :items_library_locations, :is_rarity
    end

    conf.update.columns.add_subgroup "Library, Shelfmark, Accession, Rarity (non-MARC)" do |group|
     group.add :accession_no, :items_library_locations, :is_rarity
    end
  end
  
  def duplicate
    row_id = element_row_id(:action => :list, :id => "params[:id]")
           render :update do |page|
             page.insert_html :after, row_id, :partial =>  'list_record', :locals => { :record => @record }
             page << "ActiveScaffold.stripe('#{active_scaffold_tbody_id}');"
           end
  end
  
  #used by update/create views to determine if shelfmark already in use by other item
  #see _shelfmark_form_column.rhtml in app/view/item/
  def check_duplicate_shelfmark
    @dups = ItemsLibraryLocation.find(:all, 
      :conditions => [ "shelfmark = ? AND item_id != ?", 
        params[:search], params[:item_id].blank? ? "-1" : params[:item_id] ])
    render :inline => "<%= @dups.length>0 ? '<div class=''warn''>Warning: shelfmark already in use.</div>' : '' %>"
  end
  
  def autocomplete
    @people = Person.find(:all, 
      :conditions => ["name LIKE ? OR title_100c LIKE ? OR fullname_100q LIKE ?"] + ([params[:search] + "%"] * 3).flatten)
    render :inline => "<div class='warn'>Salli " + @people.length.to_s + "</div>"
  end
   
  protected

  def set_page_name
    @pagename = "Items"
  end
    
end
