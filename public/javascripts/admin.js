// Use jQuery via jQuery(...) to avoid clashes with prototype

jQuery.noConflict();

jQuery(document).ready(function(){
 
  jQuery("#export-form-dialog").dialog({
	autoOpen: false,
	height: 180,
	width: 400,
	modal: true,
	buttons: {
		'Export items': function() {
			jQuery('#export-form').submit();
			jQuery(this).dialog('close');
		},
		Cancel: function() {
			jQuery(this).dialog('close');
		}
	},
	close: function() {}
  });

  jQuery("#item-export--link").live("click", function() {
    jQuery('#export-form-dialog').dialog('open');
    return false;
  });


});
