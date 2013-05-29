$(document).ready(function() {
  tabbing();
});

function tabbing() {
  $infoBox = $(this).siblings('.info-box');
  $graphBox= $(this).siblings('.graph-box');

  $('.graphs').on('click', function(){
    $infoBox.hide();
    $graphBox.show();
  });

  $('.info').on('click', function(){
    $graphBox.hide();
    $infoBox.show();
  });
};
