$(document).ready(function(){
  $(':checkbox').change(function(e){
    e.preventDefault();

    if ($(this).attr('checked')) {
      var theaterId = $(this).data('theater-id');
      $('.theater[data-theater-id=' + theaterId + ']').hide();
      $(this).removeAttr('checked');
    } else {
      console.log('in here')
      var theaterId = $(this).data('theater-id');
      $('.theater[data-theater-id=' + theaterId + ']').show();
      $(this).attr('checked', 'checked');
    };


    // if ($(this).prop('checked', true)) {
    //   var theaterId = $(this).data('theater-id');
    //   $('.theater[data-theater-id=' + theaterId + ']').hide();
    //   $(this).attr('disabled', $(this).is(":checked"))
    // } else {
    //   var theaterId = $(this).data('theater-id');
    //   $('.theater[data-theater-id=' + theaterId + ']').show();
    // };
    // $(this).change($(this).is(':checked'));
  })






});
