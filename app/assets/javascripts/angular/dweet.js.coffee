window.Dweet = angular.module 'Dweet', ['ngResource', 'ngRoute', 'ngAnimate', 'templates', 'youtube-embed']

Dweet.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $routeProvider.
    when '/',
      templateUrl: 'home.html',
      controller: 'HomeCtrl'

    .when '/categories/:id',
      templateUrl: 'category.html',
      controller: 'CategoryCtrl'

    .when '/categories/:id/:videoId',
      templateUrl: 'category.html',
      controller: 'CategoryCtrl'

    .otherwise
      redirectTo: '/'

  $locationProvider.html5Mode(true);
]

      