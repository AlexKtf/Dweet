Dweet.controller 'HomeCtrl', ['$scope', '$http', ($scope, $http) ->
  $http.get('/home-items.json')
    .success (data, status) ->
      $scope.videos = data
      $scope.playlists = data[1]
      $scope.loading = false
    .error (data, status) ->
      alert 'Error'

  $scope.loading = true


]
