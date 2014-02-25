/**
 * UserController
 *
 * @module      :: Controller
 * @description	:: A set of functions called `actions`.
 *
 *                 Actions contain code telling Sails how to respond to a certain type of request.
 *                 (i.e. do stuff, then send some JSON, show an HTML page, or redirect to another URL)
 *
 *                 You can configure the blueprint URLs which trigger these actions (`config/controllers.js`)
 *                 and/or override them with custom routes (`config/routes.js`)
 *
 *                 NOTE: The code you write here supports both HTTP and Socket.io automatically.
 *
 * @docs        :: http://sailsjs.org/#!documentation/controllers
 */

module.exports = {



    login: function(req, res) {


        User.findOne({username:req.body.username}).done(function (err, user) {
            if (err) res.json({ error: 'Internal error' }, 500);

            if (user) {

                    if (req.body.password == user.password) {
                        // password match
                        req.session.user = user;
                        req.session.authenticated = true;
                        user.sessionId = req.session.id;
                        res.json(user);
                    } else {
                        // invalid password
                        if (req.session.user) req.session.user = null;
                        res.json({ error: 'Invalid password' }, 400);
                    }

            } else {
                res.json({ error: 'User not found' }, 404);
            }
        });
   },

    logout: function(req, res) {
        if (req.session.user) req.session.user = null;
        req.session.authenticated = false;
        res.json({message:'User logged out'}, 200);

    },
  /**
   * Overrides for the settings in `config/controllers.js`
   * (specific to UserController)
   */
  _config: {}

  
};
