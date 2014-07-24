Dweet.controller 'CategoryCtrl', ['$scope', '$http', '$routeParams', 'filterFilter', ($scope, $http, $routeParams, filterFilter) ->
  $http.get('/categories/'+$routeParams['id']+'.json')
  .success (data, status) ->
    $scope.items = data
    $scope.allItems = data
    $scope.selectedFilter = 'all'
  .error (data, status) ->
    alert 'Error'

  $scope.itemTypeFilter = (type) ->
    $scope.selectedFilter = type

    if type != 'videos' && type != 'playlists'
      $scope.items = $scope.allItems
      return

    $scope.items = []
    angular.forEach $scope.allItems, (v, k) ->
      if angular.isUndefined(v.playlist_id) && type == 'playlists'
        $scope.items.push(v)
      if v.playlist_id == null && type == 'videos'
        $scope.items.push(v)

]