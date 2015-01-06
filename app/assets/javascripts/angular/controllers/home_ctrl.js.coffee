Dweet.controller 'HomeCtrl', ['$scope', '$http', ($scope, $http) ->
  $http.get('/home-items.json')
    .success (data, status) ->
      $scope.videos = data.home
      $scope.top_videos = data.meta.top_videos
      $scope.top_playlists = data.meta.top_playlists
      $scope.loading = false
    .error (data, status) ->
      alert 'Error'

  $scope.loading = true

]
