'use strict';
var photoControllers = angular.module('photoControllers', []);

photoControllers.controller('PhotoListCtrl', ['$scope','$upload','$http', 'Photo','Listing', function($scope,$upload,$http, Photo, Listing) {
	 
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
        tags: [] // Can be empty list.
    };

    $http
        .get('/rest/api/tag/top?count=10')
        .success(function (data, status, header, config) {
            for(var d in data){
                $scope.select2Options.tags.push(data[d].label);
            }

        })
        .error(function (data, status, headers, config) {
            $scope.message = 'Error: Could not top tags';
        });

     // handler for the for photo page initialization
	  $scope.init = function() {
		console.log("Listing Id: "+$scope.listingId);  
		if ($scope.listingId) {
			$scope.photos = Photo.query({
				id : $scope.listingId
			}, function(data) {
				 $scope.photos = data;

			}, function(errorResult) {
                $scope.message  = "Some error occurred getting photos!";
                if(errorResult.status === 403) {
                    $scope.message += ": Permission Denied"
                }});
		} else {
			$scope.listings = Listing.query(function(data) {
				$scope.listings = data;

			});
		}
	};



    $scope.doLike = function(photo) {
        Photo.like({id: photo.id}, {}, function(successResult){

            console.log('Successfully updated likes');
            photo.likes = photo.likes +1;

        });
    };

    // handler for the upload progress
    $scope.applyTags = function(photoStr) {

       var photoObj = JSON.parse(photoStr);

       console.log('Photo is '+ photoObj);
       var tags = {'tags':photoObj.tags};
       console.log('Tags sent: '+JSON.stringify(tags));
       Photo.tag({id: photoObj.id}, tags, function(successResult){
               $scope.message = "Successfully saved!";
       }, function(errorResult) {
           $scope.message  = "Some error occurred saving tags!";
           if(errorResult.status === 403) {
               $scope.message += ": Permission Denied"
           }});
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
                $scope.message = 'percent: ' + parseInt(100.0 * evt.loaded / evt.total);
            }).success(function(data, status, headers, config) {
                // file is uploaded successfully
                console.log(data);
                $scope.message = data;
            });
        //.error(...)
        //.then(success, error, progress);
        // $scope.upload = $upload.upload({...}) alternative way of uploading, sends the the file content directly with the same content-type of the file. Could be used to upload files to CouchDB, imgur, etc... for HTML5 FileReader browsers.
    };
	  
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

photoControllers.controller('AdminCtrl', ['$scope','$http', function($scope, $http) {
    console.log('Inside Admin controller');
    $scope.listings = [];
    $scope.roles = [];
    $scope.permissionsMap = {};


    $http
        .get('/listing')
        .success(function (data, status, header, config) {
            $scope.listings = data;
        })
        .error(function (data, status, headers, config) {
            $scope.message = 'Error: Could not fetch listings';
        });
    $http
        .get('/role')
        .success(function (data, status, header, config) {
            $scope.roles = data;
        })
        .error(function (data, status, headers, config) {
            $scope.message = 'Error: Could not fetch roles';
        });
    $http
        .get('/permission')
        .success(function (data, status, header, config) {
        createPermissionsMapFromPermissions(data);
        })
        .error(function (data, status, headers, config) {
            $scope.message = 'Error: Could not fetch permissions';
        });

    $scope.save = function(){
        var permissionsList = [];
        for(var l in $scope.listings){
            var ll = $scope.listings[l];
            //console.log(ll);
            for(var r in $scope.roles){
                var rr = $scope.roles[r];
                if($scope.permissionsMap[ll.id][rr.name]){
                    permissionsList.push( $scope.permissionsMap[ll.id][rr.name]);
                }
            }
        }
        $http
            .post('/rest/api/permission/save', {data: permissionsList})
            .success(function (data, status, header, config) {
                $scope.message = 'Successfully updated permissions! ';
                $http
                    .get('/permission')
                    .success(function (data, status, header, config) {
                        createPermissionsMapFromPermissions(data);
                    })
                    .error(function (data, status, headers, config) {
                        $scope.message = 'Error: Could not fetch permissions';
                    });
            })
            .error(function (data, status, headers, config) {
                $scope.message = 'Error: Updating permissions! ';
            });

    }

    function createPermissionsMapFromPermissions(data){
        $scope.permissionsMap = {};
        if(data){
            //console.log(data);
            for(var d in data){
                //console.log(data);
                var role = data[d]["role"];
                //console.log('Data index: '+d);
                if(!$scope.permissionsMap[data[d].itemId]){
                    $scope.permissionsMap[data[d].itemId] = {};
                }

                $scope.permissionsMap[data[d].itemId][role] = data[d];

            }
            // create new mappings for listing ids
            for(var l in $scope.listings){
                var ll = $scope.listings[l];
                //console.log(ll);
                if(!$scope.permissionsMap[ll.id]){
                    console.log('Inside creating mapping: ');
                    $scope.permissionsMap[ll.id] = {};
                }
            }
            // create new mappings for roles
            for(var l in $scope.listings){
                var ll = $scope.listings[l];
                //console.log(ll);
                for(var r in $scope.roles){
                    var rr = $scope.roles[r];
                    var mapping = {
                        role: rr.name,
                        itemType : 'listing',
                        itemId : ll.id,
                        read : false,
                        write : false,
                        destroy: false,
                        newRecord: true
                    };
                    //console.log('First: '+': '+ll.id+' : '+$scope.permissionsMap[ll.id]);
                    //console.log('Second: '+!$scope.permissionsMap[ll.id][rr.name]);
                    if($scope.permissionsMap[ll.id] && !$scope.permissionsMap[ll.id][rr.name]){

                        $scope.permissionsMap[ll.id][rr.name] = mapping;
                    }
                }
            }
        }
    }


}]);