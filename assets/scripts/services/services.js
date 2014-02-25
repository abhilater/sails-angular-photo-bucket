var photoServices = angular.module('photoServices', [ 'ngResource' ]);

photoServices.factory('Photo', [ '$resource', function($resource) {
	console.log('Inside photo service')
	return $resource('/rest/api/photo/:id', {}, {
		query : {
			method : 'GET',
			params : {
				id : '1'
			},
			isArray : true
		}
	});
} ]);

