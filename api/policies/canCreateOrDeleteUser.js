/**
 * canCreateUser
 *
 * @module      :: Policy
 * @description :: Simple policy to allow any authenticated user
 *                 Assumes that your login action in one of your controllers sets `req.session.authenticated = true;`
 * @docs        :: http://sailsjs.org/#!documentation/policies
 *
 */
module.exports = function(req, res, next) {

    var roles = req.session.user.roles;
    if(roles.indexOf("ADMIN")!=-1){
        next();
    }else{
        return res.forbidden('You are not permitted to perform this action.');
    }

};
