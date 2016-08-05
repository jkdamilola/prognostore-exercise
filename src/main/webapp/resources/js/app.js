// Exercise Module
var app = angular.module('prognoStoreExercise', []);

// Stock Controller
app.controller('StockController', ['$scope', '$http', function($scope, $http) {

    var obj = this;
    obj.stock;
    obj.start_date = localStorage.start_date || null;
    obj.end_date = localStorage.end_date || null;

    obj.prices = null;

    if (localStorage.prices) {
        obj.prices = JSON.parse(localStorage.prices);
    }
    
    obj.flag = localStorage.flag || 0;
    obj.points = [];
    obj.searchBtn = "Search";
    obj.symbol = localStorage.symbol || "";

    // Fetches stock info from a webservice using NASDAQ stock symbol
    obj.fetch = function() {

        if (this.stock.symbol != "") {

            obj.searchBtn = "Loading...";

            // Makes asynchronous request
            $http({method: 'GET', url: "http://localhost:8080/stock/stockinfo?symbol="+obj.stock.symbol}).
            then(function(response) {

                // Success block

                obj.searchBtn = "Search";

                obj.start_date = moment(response.data.dataset_data.start_date).format("DD/MM/YYYY");
                obj.end_date = moment(response.data.dataset_data.end_date).format("DD/MM/YYYY");
                obj.prices = response.data.dataset_data.data;
                obj.flag = 1;
                obj.symbol = obj.stock.symbol;

                localStorage.start_date = obj.start_date;
                localStorage.end_date = obj.end_date;
                localStorage.prices = JSON.stringify(obj.prices);
                localStorage.flag = obj.flag;
                localStorage.symbol = obj.symbol;

                obj.drawGraph();

            }, function(response) {

                // Failure block

                obj.searchBtn = "Search";

                alert(response.data.message);
            });
        }
    };

    // Converts returned date to a readable format
    obj.convertDate = function (val) {

        return moment(val).format("dddd (DD/MM/YYYY)");
    }

    // Generates the required datapoints to plot a line graph
    obj.dataGenerator = function () {
        // Reset datapoints
        obj.points = [];

        for (var i = 0; i < obj.prices.length; i += 1) {
            obj.points.push({
                x: new Date(moment(obj.prices[i][0]).valueOf()),
                y: obj.prices[i][1]
            });
        }

        // Reinitializes datapoints
        chart.options.data[0].dataPoints = obj.points
    }

    // Plots a line graph
    var chart = new CanvasJS.Chart("chartContainer", {

        axisX:{  
            valueFormatString: "DDDD",
            labelAngle: -50,
            title: "Day"
        },

        axisY: {
            valueFormatString: "0.0#",
            title: "Closing Stock ($)"
        },

        data: [{        
            type: "line",
            lineThickness: 2,
            dataPoints: obj.points
        }]
    });

    obj.drawGraph = function() {
        if (obj.prices != null) {
            obj.dataGenerator();
            chart.render();
        }
    }

    obj.drawGraph();
}]);    
   