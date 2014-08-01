Dweet.controller 'CategoryCtrl', ['$scope', '$http', '$routeParams', '$rootScope', '$sce', '$filter', 'filterFilter', ($scope, $http, $routeParams, $rootScope, $sce, $filter, filterFilter) ->
  $scope.selectedFilter = 'all'
  
  $http.get('/categories/'+$routeParams['id']+'.json')
  .success (data, status) ->
    $scope.items = data[0]
    $scope.allItems = data[0]
    $scope.categoryName = data[1]
    if $routeParams['videoId']?
      $scope.setSelectedVideo($filter('filter')($scope.items, {id: $routeParams['videoId']})[0])
    else
      $scope.setSelectedVideo($scope.items[0])
  .error (data, status) ->
    alert 'Error'

  $scope.setSelectedVideo = (video) ->
    $scope.selectedVideo = video
    $scope.trustAndSetIframeUrl($scope.selectedVideo)

  $scope.setRandomSelectedVideo = () ->
    randomNumber = Math.floor(Math.random()*$scope.items.length)
    $scope.selectedVideo = $scope.items[randomNumber]
    $scope.trustAndSetIframeUrl($scope.selectedVideo)

  $scope.trustAndSetIframeUrl = (video) ->
    if video.is_playlist
      $scope.url = $sce.trustAsResourceUrl('//www.youtube.com/embed/' + video.first_video_url + '?list=' + video.url)
    else
      $scope.url = $sce.trustAsResourceUrl('//www.youtube.com/embed/' + video.url)

  $scope.itemTypeFilter = (type) ->
    $scope.selectedFilter = type
    if type == 'all'
      $scope.items = $scope.allItems
      return
    $scope.items = filterFilter($scope.allItems, { is_playlist: type })
]