/**
 * TagController
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

    getTopTags: function(req, res){
        var cnt;
        if(req.query.count){
            cnt = req.query.count;
        }else{
            cnt = 10;
        }
        Tag.query('select label from tag where id in (select "tagId" from tagphoto group by "tagId" order by count(*) desc limit '+cnt+')', function(err, tags) {
            if(tags){
                res.json(tags.rows);
            }else{
                res.json([]);
            }
        });
    },

    /**
   * Overrides for the settings in `config/controllers.js`
   * (specific to TagController)
   */
  _config: {}

  
};
