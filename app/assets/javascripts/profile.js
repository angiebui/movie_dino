function tabbing() {
  $('.outing-box').on('click', '.profile-button', function(){
    $(this).siblings('.box').hide();
    $(this).siblings('.' + ($(this).attr('id')) + '-box').show();
  });
};

$(document).ready(function() {
  tabbing();
});

