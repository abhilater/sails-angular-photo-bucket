'use strict';

var app = angular.module('photoClientApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute', 
  'lvl.directives.fileupload',
  'ui.select2',
  'photoControllers',
  'photoServices'
]);
