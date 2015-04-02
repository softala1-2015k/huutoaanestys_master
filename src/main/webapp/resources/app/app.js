'use strict';

/**
 * @ngdoc overview
 * @name huutoaanestysFrontApp
 * @description
 * # huutoaanestysFrontApp
 *
 * Main module of the application.
 */
angular
  .module('huutoaanestysFrontApp', [
    'ngAnimate',
    'ngRoute'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'resources/views/main.html',
        controller: 'MainCtrl'
      })
      .when('/hops', {
        templateUrl: 'resources/views/hops.html',
        controller: 'HopsCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
