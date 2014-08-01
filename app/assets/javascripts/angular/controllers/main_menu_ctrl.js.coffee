Dweet.controller 'MainMenuCtrl', ['$scope', '$http', '$routeParams', '$rootScope', '$sce', 'filterFilter', ($scope, $http, $routeParams, $rootScope, $sce, filterFilter) ->
  $http.get('/categories.json')
  .success (data, status) ->
    $scope.categories = data
  .error (data, status) ->
    alert 'Error'

]