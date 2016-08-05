<!DOCTYPE html>
<html lang="en-US">
	<head>
		<meta charset="UTF-8" /> 
		<title>Prognostore Exercise</title>

		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/app-resources/css/bootstrap.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/app-resources/css/style.css"/>
	</head>
	<body ng-app="prognoStoreExercise">
		<h2 style="text-align: center;">PrognoStore Software Engineer Exercise</h2>
		<div class="generic-container" ng-controller="StockController as stockCtrl">
			<div class="panel panel-default">
				<!-- Default panel contents -->
				<div class="panel-heading">
					<span class="lead" style="font-size: 17px;" ng-if="stockCtrl.flag == 1">CLOSING STOCK PRICE FOR <strong>{{stockCtrl.symbol | uppercase}}</strong> BETWEEN <strong>{{stockCtrl.start_date}}</strong> AND <strong>{{stockCtrl.end_date}}</strong></span>
					<span class="lead" style="font-size: 20px;" ng-if="stockCtrl.flag == 0">STOCK MARKET APPLICATION</span>
					<div class="searchBar">
						<form class="form-inline">
							<input type="search" ng-model="stockCtrl.stock.symbol" name="symbol" class="form-control" placeholder="Search e.g. GOOG">
							<button type="button" ng-click="stockCtrl.fetch()" class="btn btn-success btn-sm">{{stockCtrl.searchBtn}}</button> 
						</form>
					</div>              
				</div>
				<div class="panel-body">
					<div class="tablecontainer">
						<table class="table table-hover" ng-if="stockCtrl.flag == 1">
							<thead>
								<tr>                             
									<th>Date</th>
									<th>Closing Stock Price</th>
								</tr>
							</thead>
							<tbody>
								<tr ng-repeat="row in stockCtrl.prices">
									<td><span ng-bind="stockCtrl.convertDate(row[0])"></span></td>
									<td>$<span ng-bind="row[1]"></span></td>
								</tr>
							</tbody>
						</table>
						<h5 style="text-align: center;" ng-if="stockCtrl.flag == 0">Search closing stock price using NASDAQ stock symbol</h5>             
					</div>

					<div id="chartContainer" style="height: 300px; width: 100%;"></div>
				</div>                
			</div>
		</div>
		<footer><p style="text-align: center">Developed by Jimoh Damilola</p></footer>>
		<script src="${pageContext.request.contextPath}/app-resources/js/lib/angular.min.js"></script>
		<script src="${pageContext.request.contextPath}/app-resources/js/lib/angular-resource.min.js"></script>
		<script src="${pageContext.request.contextPath}/app-resources/js/lib/canvasjs.min.js"></script>
		<script src="${pageContext.request.contextPath}/app-resources/js/lib/moment.js"></script>
		<script src="${pageContext.request.contextPath}/app-resources/js/lib/json2.js"></script>
		<script src="${pageContext.request.contextPath}/app-resources/js/app.js"></script>
	</body>
</html>  
  