// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var fragmentSet = false;

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    showSpinner();
    fragmentSet = true;
    $.setFragment({ "page" : "1", "search" : this.elements.search.value, "keyword" : "" });
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

$(document).ready(function() {
  $("#search_form").submitWithAjax();
})

$(function() {  
  $("#book_entry").live("click", function() {
    $.get(this.href, function(data){
      $(data).dialog({ 
        width: 500,
        position: "top",
        modal: true
      });
    });    
    return false;
  });
  
  $(".ec_pagination a").live("click", function() {
    showSpinner();

    // the next line uses the jquery.ba-url plugin to enable page fragments for browser history
    // http://benalman.com/projects/jquery-url-utils-plugin/
    fragmentSet = true;
    $.setFragment({ "page" : $.queryString(this.href).page });
    
    $.getScript(this.href);
    return false;
  });
  
  $("#category").live("click", function() {
    showSpinner();

    // the next line uses the jquery.ba-url plugin to enable page fragments for browser history
    // http://benalman.com/projects/jquery-url-utils-plugin/
    fragmentSet = true;
    if($.queryString(this.href).keyword)
      $.setFragment({ "keyword" : $.queryString(this.href).keyword, "page" : 1, "search" : "" });
    else
      $.setFragment({ "keyword" : "", "page" : 1, "search" : "" });

    $.getScript(this.href);
    
    $("#selected").attr("id", "null");
    $("li[name=" + $(this).parent().attr("name") + "]" ).attr("id", "selected");
      
    return false;
  });
  
  // with jquery.ba-url plugin listen to fragment change events
  $.fragmentChange(true);
  // act on fragment change
  $(document).bind("fragmentChange.page", function() {
    // avoid to act on fragmentChange if setFragment has already been called
    if(fragmentSet)
      fragmentSet = false;
    else {
      $.getScript($.queryString(document.location.href, { 
        "page" : $.fragment().page, 
        "search" : $.fragment().search,
        "keyword" : $.fragment().keyword
        })
      );
      $("#selected").attr("id", "null");
    }
  });
  // this is needed for bookmarks and reloads
  if ($.fragment().page) {
    $(document).trigger("fragmentChange.page");
  }
});

function showSpinner(){
  $("#pagination_top").after("<img src='../images/spinner.gif'/ class='spinner'/>");
  $("#pagination_bottom").before("<img src='../images/spinner.gif'/ class='spinner'/>");
}

