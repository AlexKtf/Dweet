Dweet.controller 'HomeCtrl', ['$scope', '$http', ($scope, $http) ->
  $scope.punchline = 'Pon di dweet'
  $http.get('/categories.json')
    .success (data, status) ->
      $scope.categories = data
    .error (data, status) ->
      alert 'Error'
]