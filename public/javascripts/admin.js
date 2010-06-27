// Use jQuery via jQuery(...) to avoid clashes with prototype

jQuery.noConflict();

jQuery(document).ready(function(){
 
  jQuery("#export-form").dialog({
	autoOpen: false,
	height: 300,
	width: 450,
	modal: true,
	buttons: {
		'Export items': function() {
			var library_id = jQuery("#library_id").val();
			//jQuery.get("item/export", { library_id: library_id } );
			//de.preventDefault();  //stop the browser from following
    			window.location.href = "item/export?library_id=" + library_id;
			jQuery(this).dialog('close');
		},
		Cancel: function() {
			jQuery(this).dialog('close');
		}
	},
	close: function() {}
  });

  jQuery("#item-export--link").live("click", function() {
    jQuery('#export-form').dialog('open');
    return false;
  });


});
