Dweet.controller 'HomeCtrl', ['$scope', '$http', '$rootScope', ($scope, $http, $rootScope) ->
  $http.get('/categories-items.json')
    .success (data, status) ->
      $scope.categoriesItems = data
    .error (data, status) ->
      alert 'Error'
]
