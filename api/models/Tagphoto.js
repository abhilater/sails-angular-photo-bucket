/**
 * Tagphoto
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

  attributes: {
  	
   tagId: {
      type: 'INTEGER',
      required: true
    },
    
    photoId: {
      type: 'INTEGER',
      required: true
    }
    
  }

};
