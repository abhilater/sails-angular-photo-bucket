/**
 * Permission
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

  attributes: {

      role: {
          type: 'STRING',
          required: true
      },
      itemType: {
          type: 'STRING',
          required: true
      },
      itemId: {
          type: 'STRING',
          required: true
      },
      read:{
          type: 'BOOLEAN',
          required: true
      },
      write:{
          type: 'BOOLEAN',
          required: true
      },
      destroy:{
          type: 'BOOLEAN',
          required: true
      }
  }

};
