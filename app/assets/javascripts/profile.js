function tabbing() {
  $('.outing-box').on('click', '.profile-button', function(){
    if (!$(this).hasClass('active')){
      $(this).siblings().removeClass('active');
      $(this).addClass('active');
      $(this).siblings('.box').fadeOut(600);
      $(this).siblings('.' + ($(this).attr('id')) + '-box').stop(true, true)
                                                           .delay(550)
                                                           .animate({
                                                             height: 'toggle',
                                                             opacity: 'toggle'
                                                           }, 600);
    };
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
            fontColor: '#666',
            font: 'normal normal 12pt Oswald',
            radius: 175,
            labelOffset: -60,
            startAngle: 45
            // labelWiring: "grey"
        });
        new MoveSlice(pieChart,'default');
        // new Tooltip(pieChart,'default');

        pieChart.addSeries('movieChart_' + index, dojo.map(element, function(gData){
          return {y: gData[1], text: gData[0] + '<br>' + gData[2]};
        }));
        pieChart.render();
    });
  });
};

function share() {
  $('.share').on('click', function(){
    $(this).hide();
    $(this).siblings('.link').fadeIn(600);
  });
};

function initialise() {
  $('.profile').hide();
  $('.profile').fadeIn(1500);
  $('.profile .info-box').hide();
  $('.profile .details-box').hide();
};

$(document).ready(function() {
  initialise();
  tabbing();
  share();
});
