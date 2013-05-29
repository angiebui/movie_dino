$(document).ready(function() {
  tabbing();
});

function tabbing() {

  $('.graphs').on('click', function(){
    console.log('')
    $(this).siblings('.info-box').hide();
    $(this).siblings('.graph-box').show();
  });

  $('.info').on('click', function(){
    $(this).siblings('.graph-box').hide();
    $(this).siblings('.info-box').show();
  });
};
