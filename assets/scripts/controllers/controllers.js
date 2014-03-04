'use strict';
var photoControllers = angular.module('photoControllers', []);

photoControllers.controller('PhotoListCtrl', ['$scope','$upload', 'Photo','Listing', function($scope,$upload, Photo, Listing) {
	 
	  console.log('Inside Photo controller');
	  $scope.message = '';
	  $scope.layout = 'grid';
	  $scope.photos = [];
      $scope.photoMap = {};
	  $scope.listingId = null;
      $scope.photoDialogShown = false;
      $scope.photoDialogPhoto = null;


    $scope.select2Options = {
        multiple: true,
        simple_tags: true,
        width:'300px',
        tags: [{id:1, text:'tag6'}, {id:2, text:'tag7'}, {id:3, text:'tag8'}, {id:4, text:'tag9'}]  // Can be empty list.
    };

     // handler for the for photo page initialization
	  $scope.init = function() {
		console.log("Listing Id: "+$scope.listingId);  
		if ($scope.listingId) {
			$scope.photos = Photo.query({
				id : $scope.listingId
			}, function(data, err) {
				if (err) {
					$scope.message = 'Error fetching data';
				} else {
					$scope.photos = data;
				}
			});
		} else {
			$scope.listings = Listing.query(function(data, err) {
				if (err) {
					$scope.message = 'Error fetching data';
				} else {
					$scope.listings = data;
				}
			});
		}
	};



    $scope.doLike = function(photo) {
        Photo.like({id: photo.id}, {}, function(){

            console.log('Successfull updated likes');
            photo.likes = photo.likes +1;

        });
    };

    // handler for the upload progress
    $scope.applyTags = function(photoStr) {

       var photoObj = JSON.parse(photoStr);

       console.log('Photo is '+ photoObj);
       var tags = {'tags':photoObj.tags};
       console.log('Tags sent: '+JSON.stringify(tags));
       Photo.tag({id: photoObj.id}, tags, function(resp, err){
           if (err) {
               $scope.message = 'Error updating tags';
           } else {
               console.log("Message: "+resp);
           }
       });
    };


    $scope.onFileSelect = function($files) {
        //$files: an array of files selected, each file has name, size, and type.

        $scope.upload = $upload.upload({
            url: '/rest/api/photo', //upload.php script, node.js route, or servlet url
            // method: POST or PUT,
            // headers: {'headerKey': 'headerValue'},
            // withCredentials: true,
            data: {listingId:$scope.listingId, isPrivate:false},
            file: $files
            // file: $files, //upload multiple files, this feature only works in HTML5 FromData browsers
            /* set file formData name for 'Content-Desposition' header. Default: 'file' */
            //fileFormDataName: myFile, //OR for HTML5 multiple upload only a list: ['name1', 'name2', ...]
            /* customize how data is added to formData. See #40#issuecomment-28612000 for example */
            //formDataAppender: function(formData, key, val){} //#40#issuecomment-28612000
        }).progress(function(evt) {
                console.log('percent: ' + parseInt(100.0 * evt.loaded / evt.total));
            }).success(function(data, status, headers, config) {
                // file is uploaded successfully
                console.log(data);
            });
        //.error(...)
        //.then(success, error, progress);
        // $scope.upload = $upload.upload({...}) alternative way of uploading, sends the the file content directly with the same content-type of the file. Could be used to upload files to CouchDB, imgur, etc... for HTML5 FileReader browsers.
    };

    /*// handler for the upload progress
	$scope.progress = function(percentDone) {
          console.log("progress: " + percentDone + "%");
    };

    // handler for the upload completion
    $scope.done = function(files, data) {
          console.log("upload complete");
          console.log("data: " + JSON.stringify(data));
          writeFiles(files);
    };

    // handlre for the sending of uoload data
    $scope.getData = function(files) { 
    	console.log('Inside get files');
    	//this data will be sent to the server with the files
    	// create an array of filenames to send to the server
    	//console.log(JSON.stringify(files));
        return {listingId:$scope.listingId, isPrivate:false};
    };

    // error handler for upload
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
    }*/
	  
	}]);



photoControllers.controller('LoginCtrl', ['$scope','$http', '$cookies', function($scope, $http, $cookies, User) {
	  console.log('Inside Login controller');
	  $scope.message = '';
	  $scope.user = null;
	  $scope.userCreds = null;

	  $scope.login = function () {
	    $http
	      .post('/rest/api/login', $scope.userCreds)
	      .success(function (data, status, header, config) {
	        $scope.message = 'Welcome ';
	        $scope.user = data;
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
		        $scope.user = null;
		      })
		      .error(function (data, status, headers, config) {
		        $scope.message = 'Error during logout';
		      });
		  };
	  
	}]);
