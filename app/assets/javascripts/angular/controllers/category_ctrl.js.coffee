Dweet.controller 'CategoryCtrl', ['$scope', '$http', '$routeParams', '$rootScope', '$sce', 'filterFilter', ($scope, $http, $routeParams, $rootScope, $sce, filterFilter) ->
  $scope.selectedFilter = 'all'
  
  $http.get('/categories/'+$routeParams['id']+'.json')
  .success (data, status) ->
    $scope.items = data
    $scope.allItems = data
    $rootScope.punchline = $scope.items[0].category.name
  .error (data, status) ->
    alert 'Error'

  $scope.itemTypeFilter = (type) ->
    $scope.selectedFilter = type
    if type == 'all'
      $scope.items = $scope.allItems
      return
    $scope.items = filterFilter($scope.allItems, { is_playlist: type })

  $scope.getRandomItem = () ->
    randomNumber = Math.floor(Math.random()*$scope.items.length)
    $scope.randomItem = $scope.items[randomNumber]

    if $scope.randomItem.is_playlist
      $scope.url = $sce.trustAsResourceUrl('//www.youtube.com/embed/' + $scope.randomItem.first_video_url + '?list=' + $scope.randomItem.url)
    else
      $scope.url = $sce.trustAsResourceUrl('//www.youtube.com/embed/' + $scope.randomItem.url)

]