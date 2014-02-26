/**
 * Photo
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

  attributes: {
    name: {
      type: 'STRING',
      required: true
    },
    size: {
      type: 'FLOAT'
    },
    likes:{
      type: 'INTEGER',
      defaultsTo: 0
    },
    listingId: {
      type: 'INTEGER',
      required: true
    },
    isPrivate: {
        type:'BOOLEAN',
        required: true
    },
    filePath: {
    	type: 'STRING',
    	required:true
    },
    thumbPath: {
    	type: 'STRING',
    	required: true
    }

  }
};
