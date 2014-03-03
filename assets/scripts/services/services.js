var photoServices = angular.module('photoServices', [ 'ngResource' ]);

photoServices.factory('Photo', [ '$resource', function($resource) {
	console.log('Inside photo service');
	return $resource('/rest/api/photo/:id/:action', {}, {
		query : {
			method : 'GET',
			params : {
				id : '@id'
			},
			isArray : true
		},
        tag : {
            method: 'POST',
            params : {
                id : '@id',
                action: 'tag'
            }
        }
	});
} ]);

photoServices.factory('Listing', [ '$resource', function($resource) {
	console.log('Inside listing service');
	return $resource('/listing', {}, {
		query : {
			method : 'GET',
			isArray : true
		}
	});
} ]);

