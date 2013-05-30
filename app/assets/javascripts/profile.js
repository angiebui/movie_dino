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

    require([
      'dojox/charting/Chart',
      'dojox/charting/plot2d/Pie',
      'dojox/charting/action2d/Tooltip',
      'dojox/charting/action2d/MoveSlice',
      'dojox/charting/themes/Minty',
      'dojo/domReady!'
    ], function(Chart, Pie, Tooltip, MoveSlice, Minty){

        Minty.chart.fill= '#F8F8F8';
        Minty.plotarea.fill = '#F8F8F8';

        var pieChart = new Chart('pieChartNode' + index);
        pieChart.setTheme(Minty);
        pieChart.addPlot('default', {
            type: 'Pie',
            fontColor: '#222',
            font: 'normal normal 12pt Oswald',
            radius: 175,
            labelOffset: -45,
            startAngle: 45,
            labelWiring: "grey"
            // htmlLabels: true
        });
        pieChart.addSeries('Movie Chart ' + index, dojo.map(element, function(pair){
          return {y: pair[1], text: pair[0], tooltip: 'test'};
        }));
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

