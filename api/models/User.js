/**
 * User
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

  attributes: {

      username: {
          type: 'STRING',
          max: 150,
          required: true
      },
      email: {
          type: 'EMAIL',
          required: false
      },
      fullname: {
          type: 'STRING',
          max: 350,
          required: true
      },
      password: {
          type: 'STRING',
          required: true
      },
      roles:{
          type: 'ARRAY',
          required:true
      },
      sessionId: {
    	  type: 'STRING'
      }
      
  }


};
