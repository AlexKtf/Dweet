Dweet.controller 'CategoryCtrl',
['$scope', '$http', '$routeParams', '$rootScope', '$sce', '$filter', '$youtube', '$timeout', 'filterFilter',
($scope, $http, $routeParams, $rootScope, $sce, $filter, $youtube, $timeout, filterFilter) ->
  

  $scope.selectedFilter = 'all'
  $scope.radioClip = false
  $scope.loading = true

  $http.get('/categories/'+$routeParams['id']+'.json')
  .success (data, status) ->
    $scope.categoryName = data[0].category_name
    $scope.items = data
    $scope.allItems = data
    if $routeParams['videoId']?
      $scope.setSelectedVideo($filter('filter')($scope.items, {id: $routeParams['videoId']})[0])
    else
      $scope.setSelectedVideo($scope.items[0])
    $scope.loading = false

  .error (data, status) ->
    alert 'Error'


  $scope.initRadioClip = () ->
    $scope.radioClip = true
    $scope.selectedVideo = null
    $scope.radioCurrentIndex = 0
    $scope.prevClip = null
    $scope.nextClip = null

  $scope.setRadioClip = () ->
    return if $scope.radioClip

    $scope.initRadioClip()
    $scope.radioItems = filterFilter($scope.allItems, { is_playlist: false })
    $scope.clip = $scope.radioItems[0]
    $scope.nextClip = $scope.radioItems[1]

  $scope.nextRadioClip = () ->
    $scope.radioCurrentIndex = $scope.radioCurrentIndex + 1
    $scope.setPrevAndNextRadioClip()
    $scope.clip = $scope.radioItems[$scope.radioCurrentIndex]

    if !$scope.nextClip?
      $scope.letRepeatRadio = true
      return

  $scope.repeatRadioClip = () ->
    $scope.radioClip = false
    $scope.letRepeatRadio = false
    $scope.setRadioClip()

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
    $scope.fullUrl = $sce.trustAsResourceUrl(video.yt_url)


  $scope.itemTypeFilter = (type) ->
    $scope.selectedFilter = type
    if type == 'all'
      $scope.items = $scope.allItems
      return
    $scope.items = filterFilter($scope.allItems, { is_playlist: type })
]