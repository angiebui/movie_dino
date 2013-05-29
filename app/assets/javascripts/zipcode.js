var enterZipcode = function(){
  $('#search_button').on('click',function(e){
    e.preventDefault();
    $('#zipcode_form').find('[type="submit"]').trigger('click');
  });
}

$(document).ready(function(){
  enterZipcode();
});
