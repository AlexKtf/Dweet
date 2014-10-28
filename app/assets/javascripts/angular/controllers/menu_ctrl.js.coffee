Dweet.controller 'MenuCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

  $scope.$on '$routeChangeSuccess', () ->
    if $scope.pageIsKnown
      $scope.pageIsKnown = false
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
