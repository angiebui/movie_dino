$(document).ready(function() {
  $('.graphs').on('click', function(){
    console.log($(this).siblings('.graph-box'))
    $(this).siblings('.info-box').hide();
    $(this).siblings('.graph-box').show();
  });

  $('.info').on('click', function(){
    $(this).siblings('.info-box').show();
    $(this).siblings('.graph-box').hide();
  });
});
