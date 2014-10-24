Dweet.controller 'MenuCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

  $http.get('/categories.json')
    .success (data, status) ->
      $scope.categories = data
    .error (data, status) ->
      alert 'Error'


  $scope.$on '$routeChangeSuccess', () ->
    if $scope.pageIsKnown?
      $scope.known = false
      return

    if $location.url() == '/'
      $scope.activeCategoryId = 0
      return

    $scope.activeCategoryId = $scope.getCategoryId()

    
  $scope.getCategoryId = () ->
    index = $location.url().indexOf('-')
    return $location.url().slice(12, index)

  $scope.setActivePage = (page) ->
    $scope.pageIsKnown = true
    $scope.activeCategoryId = page


]
