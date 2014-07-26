Dweet.controller 'CategoryCtrl', ['$scope', '$http', '$routeParams', '$rootScope', 'filterFilter', ($scope, $http, $routeParams, $rootScope, filterFilter) ->
  $http.get('/categories/'+$routeParams['id']+'.json')
  .success (data, status) ->
    $scope.items = data
    $scope.allItems = data
    $scope.selectedFilter = 'all'
    $rootScope.punchline = $scope.items[0].category.name
  .error (data, status) ->
    alert 'Error'

  $scope.itemTypeFilter = (type) ->
    $scope.selectedFilter = type
    if type == 'all'
      $scope.items = $scope.allItems
      return

    $scope.items = filterFilter($scope.allItems, { is_playlist: type })
]