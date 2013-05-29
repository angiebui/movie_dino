$(document).ready(function() {
  $('.graphs').on('click', function(){
    $('.info-box').hide();
    $('.graph-box').show();
  });

  $('.info').on('click', function(){
    $('.graph-box').hide();
    $('.info-box').show();
  });
});
