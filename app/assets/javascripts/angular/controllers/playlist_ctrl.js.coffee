Dweet.controller 'PlaylistCtrl', ['$scope', '$http', '$routeParams', '$sce', ($scope, $http, $routeParams, $sce) ->
  $http.get('/playlists/'+$routeParams['id']+'.json')
  .success (data, status) ->
    $scope.playlist = data
    $scope.url = $sce.trustAsResourceUrl('//www.youtube.com/embed/' + $scope.playlist.videos[0].url + '?list=' + $scope.playlist.url)
  .error (data, status) ->
    alert 'Error'
]