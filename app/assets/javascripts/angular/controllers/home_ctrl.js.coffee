Dweet.controller 'HomeCtrl', ['$scope', '$http', ($scope, $http) ->
  $http.get('/home-items.json')
    .success (data, status) ->
      $scope.videos = data[0]
      $scope.top_videos = data[1]
      $scope.top_playlists = data[2]
      $scope.loading = false
    .error (data, status) ->
      alert 'Error'

  $scope.loading = true

]
