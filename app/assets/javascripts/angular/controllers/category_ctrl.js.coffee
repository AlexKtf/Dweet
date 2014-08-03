Dweet.controller 'CategoryCtrl',
['$scope', '$http', '$routeParams', '$rootScope', '$sce', '$filter', '$youtube', '$timeout', 'filterFilter',
($scope, $http, $routeParams, $rootScope, $sce, $filter, $youtube, $timeout, filterFilter) ->
  
  $http.get('/categories/'+$routeParams['id']+'.json')
  .success (data, status) ->
    $scope.items = data[0]
    $scope.allItems = data[0]
    $scope.radioItems = filterFilter($scope.allItems, { is_playlist: false })
    $scope.categoryName = data[1]
    if $routeParams['videoId']?
      $scope.setSelectedVideo($filter('filter')($scope.items, {id: $routeParams['videoId']})[0])
    else
      $scope.setSelectedVideo($scope.items[0])
  .error (data, status) ->
    alert 'Error'

  $scope.selectedFilter = 'all'
  $scope.radioClip = false

  $scope.setRadioClip = () ->
    return if $scope.radioClip
    $scope.radioClip = true
    $scope.selectedVideo = null
    $scope.radioCurrentIndex = 0
    $scope.radioTotalCount = $scope.radioItems.length
    $scope.clip = $scope.radioItems[0]
    $scope.nextClip = $scope.radioItems[1]

  $scope.nextRadioClip = () ->
    $scope.radioCurrentIndex = $scope.radioCurrentIndex + 1
    $scope.clip = $scope.radioItems[$scope.radioCurrentIndex]
    $scope.setPrevAndNextRadioClip()

  $scope.prevRadioClip = () ->
    $scope.radioCurrentIndex = $scope.radioCurrentIndex - 1
    $scope.clip = $scope.radioItems[$scope.radioCurrentIndex]
    $scope.setPrevAndNextRadioClip()

  $scope.setPrevAndNextRadioClip = () ->
    $scope.nextClip = $scope.radioItems[$scope.radioCurrentIndex + 1] ? null
    $scope.prevClip = $scope.radioItems[$scope.radioCurrentIndex - 1] ? null

  $scope.displayRadioIndex = () ->
    return $scope.radioCurrentIndex + 1

  $scope.$on 'youtube.player.ended', () ->
    $timeout () ->
      $scope.nextRadioClip()
    , 1000

  $scope.$on 'youtube.player.ready', () ->
    $youtube.player.playVideo() if $scope.radioClip

  $scope.setRandomSelectedVideo = () ->
    $scope.radioClip = false
    randomNumber = Math.floor(Math.random()*$scope.items.length)
    $scope.setSelectedVideo($scope.items[randomNumber])

  $scope.setSelectedVideo = (video) ->
    $scope.radioClip = false
    $scope.selectedVideo = video
    $scope.fullUrl = video.url
    $scope.fullUrl = video.first_video_url + '?list=' + $scope.fullUrl if video.is_playlist
    $scope.fullUrl = $sce.trustAsResourceUrl('//youtube.com/embed/' + $scope.fullUrl)


  $scope.itemTypeFilter = (type) ->
    $scope.selectedFilter = type
    if type == 'all'
      $scope.items = $scope.allItems
      return
    $scope.items = filterFilter($scope.allItems, { is_playlist: type })
]