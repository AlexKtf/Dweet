Dweet.controller 'CategoryCtrl',
['$scope', '$http', '$routeParams', '$rootScope', '$sce', '$filter', '$youtube', '$timeout', 'filterFilter',
($scope, $http, $routeParams, $rootScope, $sce, $filter, $youtube, $timeout, filterFilter) ->

  $scope.selectedFilter = 'all'
  $scope.radioClip = false
  $scope.loading = true
  $scope.randomizeRadioClip = false
  $scope.repeatizeRadioClip = false

  $http.get('/categories/'+$routeParams['id']+'.json')
  .success (data, status) ->
    $scope.categoryName = data[0].category_name
    $scope.items = data
    $scope.allItems = data
    if $routeParams['videoId']?
      end_of_id = $routeParams['videoId'].indexOf('-')
      id = $routeParams['videoId'].slice(0, end_of_id)
      $scope.setSelectedVideo($filter('filter')($scope.items, {id: id})[0])
    else
      $scope.setSelectedVideo($scope.items[0])
    $scope.loading = false
  .error (data, status) ->
    alert 'Error'


  $scope.initRadioClip = () ->
    $scope.radioClip = true
    $scope.selectedVideo = null
    $scope.radioCurrentIndex = 0
    $scope.randomNumber = 0
    $scope.alreadyPlayedInRandom = []
    $scope.letRepeatFlow = false

  $scope.setRadioClip = () ->
    return if $scope.radioClip

    $scope.initRadioClip()
    $scope.radioItems = filterFilter($scope.allItems, { is_playlist: false })
    $scope.clip = $scope.radioItems[$scope.radioCurrentIndex]
    $scope.alreadyPlayedInRandom.push($scope.radioCurrentIndex)

  $scope.nextRadioClip = () ->
    if !$scope.randomizeRadioClip
      clip = $scope.getNextVideo()

      return $scope.automaticRepeatOrNot() if !clip?
      $scope.clip = clip
    else
      return $scope.automaticRepeatOrNot() if $scope.alreadyPlayedInRandom.length == $scope.radioItems.length
      $scope.clip = $scope.getRandomAvalaibleVideo()


  $scope.getRandomAvalaibleVideo = () ->
    $scope.randomNumber = Math.floor(Math.random()*$scope.radioItems.length) while $scope.alreadyPlayedInRandom.indexOf($scope.randomNumber) > -1
    $scope.alreadyPlayedInRandom.push($scope.randomNumber)
    return $scope.radioItems[$scope.randomNumber]

  $scope.getNextVideo = () ->
    $scope.radioCurrentIndex = $scope.radioCurrentIndex + 1
    return $scope.radioItems[$scope.radioCurrentIndex]

  $scope.automaticRepeatOrNot = () ->
    if $scope.repeatizeRadioClip
      $scope.repeatRadioClip()
    else
      $scope.letRepeatFlow = true

  $scope.repeatRadioClip = () ->
    $scope.radioClip = false
    $scope.setRadioClip()


  $scope.$on 'youtube.player.ended', () ->
    $scope.nextRadioClip()

  $scope.$on 'youtube.player.ready', () ->
    $youtube.player.playVideo() if $scope.radioClip
  
  $scope.radioClipToRandom = () ->
    $scope.randomizeRadioClip = !$scope.randomizeRadioClip

  $scope.radioClipToRepeat = () ->
    $scope.repeatizeRadioClip = !$scope.repeatizeRadioClip


  $scope.setSelectedVideo = (video) ->
    $scope.clip = false
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