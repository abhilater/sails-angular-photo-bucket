module.exports = function(req, res, next) {

  // add common response headers for all response objects
 res.setHeader('Access-Control-Allow-Origin', '*');
 return next();
  
};
