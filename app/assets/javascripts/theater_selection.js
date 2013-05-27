$(document).ready(function(){
  theaterFilter();
  movieFilter();
});

function theaterFilter()
{
  $('.theater-filter :checkbox').change(function(e){
    e.preventDefault();
    var theaterId = $(this).data('theater-id');

    if ($(this).attr('checked')) {
      $('.theater[data-theater-id=' + theaterId + ']').hide();
      $(this).removeAttr('checked');
    } else {
      $('.theater[data-theater-id=' + theaterId + ']').show();
      $(this).attr('checked', 'checked');
    };
  })
};

function movieFilter()
{
  $('.movie-filter :checkbox').change(function(e){
    e.preventDefault();
    var movieId = $(this).data('movie-id');

    if($(this).attr('checked')) {
      $('.movie[data-movie-id=' + movieId + ']').hide();
      $(this).removeAttr('checked');
    } else {
      $('.movie[data-movie-id=' + movieId + ']').show();
      $(this).attr('checked', 'checked');
    };
  });
};
