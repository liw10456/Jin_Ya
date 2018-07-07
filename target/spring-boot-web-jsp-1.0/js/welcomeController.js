angular.module("welcomeApp", [])
	.controller("welcomeCtrl", function($scope,$http){
	$scope.date = new Date();
	$scope.month = $scope.date.getMonth();
    var onUserComplete = function(response){
    	$scope.weatherTemp = (response.data.currently.apparentTemperature-32)* 5.0/9.0;
    	$scope.weatherSummary = response.data.daily.icon;
    };
    
    var onError = function(reason){
    	$scope.error = "Could not fetch the user";
    }
    
    $scope.test = "[[${profile}]]";
    //$scope.currentUser = 
    $http.get("https://api.forecast.io/forecast/d566f2b1f6388d5806111a564ad8ec3f/24.8138,120.9675")
    	.then(onUserComplete, onError);
    $scope.getNeighboodEventInfo = function(category, id){
    	$http.get("/HSIN_CHU/JIN_YA"+"/event/"+category+"/"+id).then(function(response) {
    		$scope.eventInfo = response.data;
    		$('#eventInfoModal').modal('show');
    		console.log("JSON.stringify:"+JSON.stringify(response));
    		
        });
    }

    
    $scope.reset = function(){
    	$route.reload();
    }
    
    $scope.createActivity = function(event){
//    	event.startTime = $('#datetimepicker1').datetimepicker();
//    	event.endTime = $('#datetimepicker2').datetimepicker();
    	console.log("obj----"+JSON.stringify(event));
    	
    	$http({
            method : 'POST',
            url : 'activity',
            data : event,
            headers: {
                'Content-Type': 'application/json'
            }
        }).success(function(data) {
            console.log(data);
            $scope.reset();
        }).error(function(data) {
            console.log(data);
        });
        console.log("POST done");
    }
    
    
  });