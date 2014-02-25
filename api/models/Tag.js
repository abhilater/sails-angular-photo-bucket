/**
 * Tag
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

  attributes: {
  	
    label: {
      type: 'STRING',
      max: 150,
      required: true
    },
    
    description: {
      type: 'STRING',
      required: false
    }
    
  }

};
