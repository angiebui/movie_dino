function tabbing() {
  $('.outing-box').on('click', '.profile-button', function(){
    $(this).siblings().removeClass('active');
    $(this).addClass('active');
    $(this).siblings('.box').hide();
    $(this).siblings('.' + ($(this).attr('id')) + '-box').show();
  });
};

function chart() {
  require([
    "dojox/charting/Chart",
    "dojox/charting/plot2d/Pie",
    "dojox/charting/action2d/Tooltip",
    "dojox/charting/action2d/MoveSlice",
    "dojox/charting/themes/PlotKit/cyan",
    "dojo/domReady!"
  ], function(Chart, Pie, Tooltip, MoveSlice, PlotKitCyan){

      var pieChart = new Chart("pieChartNode0");
      pieChart.setTheme(PlotKitCyan);
      pieChart.addPlot("default", {
          type: "Pie",
          fontColor: "#000"
      });
      pieChart.addSeries('Movie Chart', [4,4,1]);
      new MoveSlice(pieChart,"default");
      new Tooltip(pieChart,"default");
      pieChart.render();
  });
    require([
    "dojox/charting/Chart",
    "dojox/charting/plot2d/Pie",
    "dojox/charting/action2d/Tooltip",
    "dojox/charting/action2d/MoveSlice",
    "dojox/charting/themes/PlotKit/cyan",
    "dojo/domReady!"
  ], function(Chart, Pie, Tooltip, MoveSlice, PlotKitCyan){

      var pieChart = new Chart("pieChartNode1");
      pieChart.setTheme(PlotKitCyan);
      pieChart.addPlot("default", {
          type: "Pie",
          fontColor: "#000"
      });
      pieChart.addSeries('Movie Chart', [2,2,1,23,5,3,6]);
      new MoveSlice(pieChart,"default");
      new Tooltip(pieChart,"default");
      pieChart.render();
  });
};

$(document).ready(function() {
  tabbing();
  chart();
});

