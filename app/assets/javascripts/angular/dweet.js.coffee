window.Dweet = angular.module 'Dweet', ['ngResource', 'ngRoute', 'ngAnimate', 'templates']

Dweet.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $routeProvider.
    when '/',
      templateUrl: 'home.html',
      controller: 'HomeCtrl'

    .when '/categories/:id',
      templateUrl: 'category.html',
      controller: 'CategoryCtrl'

    .when '/videos/:id',
      templateUrl: 'video.html',
      controller: 'VideoCtrl'

    .when '/playlists/:id',
      templateUrl: 'playlist.html',
      controller: 'PlaylistCtrl'

    .otherwise
      redirectTo: '/'

  $locationProvider.html5Mode(true);
]

      