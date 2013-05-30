function tabbing() {
  $('.outing-box').on('click', '.profile-button', function(){
    $(this).siblings().removeClass('active');
    $(this).addClass('active');
    $(this).siblings('.box').hide();
    $(this).siblings('.' + ($(this).attr('id')) + '-box').show();
  });
};

function getJSonObject(value) {
  return $.parseJSON(value.replace(/&quot;/ig, '"'));
};

function generateCharts(attendees) {
  $.each(getJSonObject(attendees), function(index, element) {
    var attendeeList = []
    $.each(element, function(i, e) {
      attendeeList.push(e[1])
    });

    require([
      'dojox/charting/Chart',
      'dojox/charting/plot2d/Pie',
      'dojox/charting/action2d/Tooltip',
      'dojox/charting/action2d/MoveSlice',
      'dojox/charting/themes/PlotKit/cyan',
      'dojo/domReady!'
    ], function(Chart, Pie, Tooltip, MoveSlice, PlotKitCyan){

        var pieChart = new Chart('pieChartNode' + index);
        pieChart.setTheme(PlotKitCyan);
        pieChart.addPlot('default', {
            type: 'Pie',
            fontColor: '#000',
            radius: 175
        });
        pieChart.addSeries('Movie Chart ' + index, attendeeList);
        new MoveSlice(pieChart,'default');
        new Tooltip(pieChart,'default');
        pieChart.render();

    });
  });
};

$(document).ready(function() {
  tabbing();
  $('.profile .info-box').hide();
});

