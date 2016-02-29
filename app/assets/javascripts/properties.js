$(".properties.index, .properties.paginate").ready(function(){
  $(".map-link").click(function(e){
    e.preventDefault();
    var address=$(this).data("address");
    var enc_address=encodeURIComponent(address);
    var uri="https://www.google.com/maps/embed/v1/place?key=AIzaSyAjjZwau6weZYUm1e_rm2IEo95NCAzqoHY&q="+enc_address;
    $("#map-iframe").prop("src", uri);
    $("#maps-modal-label").text(address);    
  });
});
$(".properties.new, .properties.edit, .properties.show").ready(function(){
  $("#select-customer").change(function(){
    if($(this).val() != "") {
      $("#btn-add-customer").prop("disabled", false);
    } else {
      $("#btn-add-customer").prop("disabled", "disabled");
    }
  })  
});