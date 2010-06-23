// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var currentQuery = "";

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

// search 
// jQuery.fn is a shortcut for jQuery.prototype and a prototype in javascript is like a class that can be extended
// define a function and add it as submitWithAjax method to the jquery object's prototype
jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    showSpinner();
    
    currentQuery = "search=" + this.elements.search.value;
    
    $("#selected").attr("id", "null");

    // search --> #search=THESEARCH (remove page and keywords parameter)
    // using jQuery BBQ: Back Button & Query Library http://benalman.com/projects/jquery-bbq-plugin/
    $.bbq.pushState( { "search" : this.elements.search.value }, 2 );
    
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });
  return this;
};

$(document).ready(function() {
  // call function as method of an object: the function's local this keyword is bound to that object for that invocation.
  $("#search_form").submitWithAjax();
  
  
  // show book details in light box
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


  // paginate
  $(".ec_pagination a").live("click", function() {
    showSpinner();

    if($.deparam.querystring(this.href).search)
      currentQuery = "search=" + $.deparam.querystring(this.href).search + "&page=" + $.deparam.querystring(this.href).page
    else
      currentQuery = $.param.querystring(this.href);
      
    // paginate --> #keywords[]=THEKEYWORDS&search=THESEARCH&page=NEXT/PREV (keep keywords and search parameter)
    // using jQuery BBQ: Back Button & Query Library http://benalman.com/projects/jquery-bbq-plugin/
    $.bbq.pushState( { "page" : $.deparam.querystring(this.href).page } );

    $.getScript(this.href);
    return false;
  });


  // category click
  $(".category").live("click", function() {
    showSpinner();
    
    currentQuery = $.param.querystring(this.href);

    $("#selected").attr("id", "null");
    $("li[name=" + $(this).parent().attr("name") + "]" ).attr("id", "selected");

    // click on category --> #keywords[]=THEKEYWORDS (remove page and search parameter)
    // using jQuery BBQ: Back Button & Query Library http://benalman.com/projects/jquery-bbq-plugin/
    $.bbq.pushState( { "keywords" : $.deparam.querystring(this.href).keywords }, 2 );
  
    $.getScript(this.href);

    return false;
  });


  // Bind an event to window.onhashchange that, when the history state changes,
  // gets the url from the hash and displays either our cached content or fetches
  // new content to be displayed.
  $(window).bind( 'hashchange', function(e) {

    // Get the hash (fragment) as a string, with any leading # removed. Note that
    // in jQuery 1.4, you should use e.fragment instead of $.param.fragment().
    var fragment = $.param.fragment();

    if(currentQuery!=fragment) {
      currentQuery = fragment;
      
      showSpinner();
      
      $.getScript(location.pathname + "?" + fragment);
    }
  })
    

    // Since the event is only triggered when the hash changes, we need to trigger
    // the event now, to handle the hash the page may have loaded with.
    $(window).trigger( 'hashchange' );
  
  // TODOS: fixed position for pagination bar  
})



function showSpinner(){
  $("#pagination_bottom").before("<img src='images/spinner.gif' class='spinner'/>");
}

