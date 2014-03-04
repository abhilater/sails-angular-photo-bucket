/**
 * app.js
 *
 * This file contains some conventional defaults for working with Socket.io + Sails.
 * It is designed to get you up and running fast, but is by no means anything special.
 *
 * Feel free to change none, some, or ALL of this file to fit your needs!
 */


(function (io) {

  // as soon as this file is loaded, connect automatically, 
  var socket = io.connect();
  if (typeof console !== 'undefined') {
    log('Connecting to Sails.js...');
  }

  socket.on('connect', function socketConnected() {
	
	socket.request('/photo/subscribe', {}, function(response){
		console.log("Socket Response: "+response);
	});

    // Listen for Comet messages from Sails
    socket.on('message', cometMessageReceivedFromServer);
   

    ///////////////////////////////////////////////////////////
    // Here's where you'll want to add any custom logic for
    // when the browser establishes its socket connection to 
    // the Sails.js server.
    ///////////////////////////////////////////////////////////
    log(
        'Socket is now connected and globally accessible as `socket`.\n' + 
        'e.g. to send a GET request to Sails, try \n' + 
        '`socket.get("/", function (response) ' +
        '{ console.log(response); })`'
    );
    ///////////////////////////////////////////////////////////


  });


  // Expose connected `socket` instance globally so that it's easy
  // to experiment with from the browser console while prototyping.
  window.socket = socket;


  // Simple log function to keep the example simple
  function log () {
    if (typeof console !== 'undefined') {
      console.log.apply(console, arguments);
    }
  }
  

})(

  // In case you're wrapping socket.io to prevent pollution of the global namespace,
  // you can replace `window.io` with your own `io` here:
  window.io

);

/*
 * This callback function handles the comet message from server based on the model 
 */
function cometMessageReceivedFromServer(message) {
	console.log('New comet message received :: ', message);
	if(message.model === 'photo'){
		updatePhotoInDom(message);
	}
}

function updatePhotoInDom(photo){
    var scope = angular.element($("#photoMainDiv")).scope();
    //console.log("Scope Photos before: "+JSON.stringify(scope.photos));
    //console.log("Photo: "+JSON.stringify(photo));
    
    scope.$apply(function() {
        scope.photos.unshift(photo.data);
        //console.log("Scope Photos before: "+JSON.stringify(scope.photos));
    });
}

