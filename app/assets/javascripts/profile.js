function tabbing() {
  $('.outing-box').on('click', '.profile-button', function(){
    $(this).siblings().removeClass('active');
    $(this).addClass('active');
    $(this).siblings('.box').hide();
    $(this).siblings('.' + ($(this).attr('id')) + '-box').show();
  });
};



$(document).ready(function() {
  tabbing();

  require([
    "dojox/charting/Chart",
    "dojox/charting/plot2d/Pie",
    "dojox/charting/action2d/Tooltip",
    "dojox/charting/action2d/MoveSlice",
    "dojox/charting/themes/PlotKit/green",
    "dojo/domReady!"
], function(Chart, Pie, Tooltip, MoveSlice, PlotKitGreen){
 
    var pieChart = new Chart("pieChartNode");
    pieChart.setTheme(PlotKitGreen);
    pieChart.addPlot("default", {
        type: "Pie",
        fontColor: "#000"
    });
    pieChart.addSeries("Series A", [5,8,10,40,20]);
    new MoveSlice(pieChart,"default");
    new Tooltip(pieChart,"default");
    pieChart.render();
});
});

