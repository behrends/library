// Use jQuery via jQuery(...) to avoid clashes with prototype

jQuery.noConflict();

jQuery(document).ready(function(){
  
  // export: dialog to choose library from which to export
  jQuery("#item-export--link").live("click", function() {
    alert('export...!')    
    return false;
  });
});
