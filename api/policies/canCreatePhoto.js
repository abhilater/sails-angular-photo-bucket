/**
 * canCreatePhoto
 *
 * @module      :: Policy
 * @description :: Simple policy to allow any authenticated user
 *                 Assumes that your login action in one of your controllers sets `req.session.authenticated = true;`
 * @docs        :: http://sailsjs.org/#!documentation/policies
 *
 */
module.exports = function(req, res, next) {


    var targetListingId = req.body.listingId;
    var roles = req.session.user.roles;
    console.log("Check: "+req.session.user.username);
    if(!roles){
        return res.forbidden('You are not permitted to perform this action.');
    }
    Permission
        .find( {itemType:'listing', itemId:targetListingId, write:true} )
        .done( function (err, permissions) {

            // Unexpected error occurred-- skip to the app's default error (500) handler
            if (err) return next(err);

            if ( ! permissions || (permissions && permissions.length < 1)) return res.forbidden('You are not permitted to perform this action.');
            var permitted = false;
            permissions.forEach(function(permission){
                console.log("Permission: "+permission);
                if(roles.indexOf(permission.role)!=-1){
                    permitted = true;
                    next();

                }
            });
            if(!permitted){
                return res.forbidden('You are not permitted to perform this action.');
            }
        });


};
