'use strict';
var photoControllers = angular.module('photoControllers', []);

photoControllers.controller('PhotoListCtrl', ['$scope', 'Photo', function($scope, Photo) {
	  console.log('Inside Photo controller');
	  $scope.layout = 'grid';
	  $scope.photos = Photo.query();
	}]);

photoControllers.controller('LoginCtrl', ['$scope','$http', '$cookies', function($scope, $http, $cookies) {
	  console.log('Inside Login controller');
	  $scope.user = null;
	  $scope.message = '';
	  $scope.loggedin = false;
	  $scope.login = function () {
	    $http
	      .post('/rest/api/login', $scope.user)
	      .success(function (data, status, header, config) {
	        $scope.message = 'Welcome ';
	        $scope.loggedin = true;
	      })
	      .error(function (data, status, headers, config) {
	        $scope.message = 'Error: Invalid user or password';
	      });
	  };
	  
	  $scope.logout = function () {
		    $http
		      .get('/rest/api/logout')
		      .success(function (data, status, headers, config) {
		        $scope.message = ' ';
		        $scope.loggedin = false;
		      })
		      .error(function (data, status, headers, config) {
		        $scope.message = 'Error during logout';
		      });
		  };
	  
	}]);

photoControllers.controller('FileUploadCtrl', ['$scope', function($scope) {
	console.log('Inside upload controller');
    $scope.progress = function(percentDone) {
          console.log("progress: " + percentDone + "%");
    };

    $scope.done = function(files, data) {
          console.log("upload complete");
          console.log("data: " + JSON.stringify(data));
          writeFiles(files);
    };

    $scope.getData = function(files) { 
    	console.log('Inside get files');
    	//this data will be sent to the server with the files
    	// create an array of filenames to send to the server
    	//console.log(JSON.stringify(files));
        return {listingId:1, isPrivate:false};
    };

    $scope.error = function(files, type, msg) {
          console.log("Upload error: " + msg);
          console.log("Error type:" + type);
          writeFiles(files);
    }

    function writeFiles(files) 
    {
          console.log('Files')
          for (var i = 0; i < files.length; i++) {
                console.log('\t' + files[i].name);
          }
    }
}]);
