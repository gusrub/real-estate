$(".row.summary").ready(function(){
  function checkSearchBox() {
    $("#search_btn").prop("disabled", $("#search_criteria").val() == "");
  }
  $("#search_criteria").keyup(checkSearchBox);

  // call this on load so we disable search button initially
  checkSearchBox();  
});