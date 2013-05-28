$(document).ready(function(){
  theaterFilter();
  movieFilter();
});

function theaterFilter()
{
  $('.theater-filter :checkbox').change(function(e){
    e.preventDefault();
    var theaterId = $(this).data('theater-id');
    var $theaterBox = $('.theater[data-theater-id=' + theaterId + ']')

    if ($(this).attr('checked')) {
      $theaterBox.hide();
      $(this).removeAttr('checked');
      $theaterBox.find('.showtime-checkbox').children().removeAttr('checked');
    } else {
      $theaterBox.show();
      $(this).attr('checked', 'checked');
    };
  })
};

function movieFilter()
{
  $('.movie-filter :checkbox').change(function(e){
    e.preventDefault();
    var movieId = $(this).data('movie-id');
    var $movieCheckBoxes = $('.movie[data-movie-id=' + movieId + ']')

    if($(this).attr('checked')) {
      $movieCheckBoxes.hide();
      $(this).removeAttr('checked');
      $movieCheckBoxes.find('.showtime-checkbox').children().removeAttr('checked');
    } else {
      $movieCheckBoxes.show();
      $(this).attr('checked', 'checked');
    };
  });
};
