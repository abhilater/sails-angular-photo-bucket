/**
 * PermissionController
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


    save: function(req, res) {
        var list = req.body.data;
        var count = 0;
        if(list){
            count = list.length;
            list.forEach(function(permission){
                if(permission.newRecord){
                    delete permission['newRecord'];
                    Permission.create(permission).done(function(err) {
                        count--;
                        if (err) {
                            res.json(err);
                        } else {
                            console.log("One permission created");
                        }
                        if(count == 0) res.json("All permissions updated");
                    });
                }else{
                    Permission.update({
                        itemId: permission.itemId,
                        itemType: permission.itemType,
                        role: permission.role
                    },{
                        read: permission.read,
                        write: permission.write,
                        destroy: permission.destroy
                    }, function(err, permissions) {
                        // Error handling
                        count--;
                        if (err) {
                            res.json(err);
                            // Updated users successfully!
                        } else {
                            console.log("Permission updated:", permissions);
                        }
                        if(count == 0) res.json("All permissions updated");
                    });
                }
            });
        }


    },

  /**
   * Overrides for the settings in `config/controllers.js`
   * (specific to PermissionController)
   */
  _config: {}

  
};
