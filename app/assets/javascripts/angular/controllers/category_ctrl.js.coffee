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
    $scope.categoryName = data.meta.category_name
    $scope.items = data.categories
    $scope.allItems = data.categories
    $scope.subcategories = data.meta.subcategories_names
    $scope.loading = false
    $scope.setRadioClip()
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
    if $routeParams['videoId']?
      video_id = getVideoId()
      angular.forEach $scope.radioItems, (item, key) ->
        $scope.radioCurrentIndex = key if (video_id - item.id) == 0
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

  $scope.setSelectedVideo = (video) ->
    selected = $filter('filter')($scope.radioItems, {id: video.id})
    return if selected.length == 0
    $scope.clip = selected[0]

  $scope.$on 'youtube.player.ended', () ->
    $scope.nextRadioClip()

  $scope.$on 'youtube.player.ready', () ->
    $youtube.player.playVideo() if $scope.radioClip
  
  $scope.radioClipToRandom = () ->
    $scope.randomizeRadioClip = !$scope.randomizeRadioClip

  $scope.radioClipToRepeat = () ->
    $scope.repeatizeRadioClip = !$scope.repeatizeRadioClip

  getVideoId = () ->
    end_of_id = $routeParams['videoId'].indexOf('-')
    return $routeParams['videoId'].slice(0, end_of_id)


  $scope.itemTypeFilter = (type) ->
    $scope.selectedFilter = type
    if type == 'all'
      $scope.items = $scope.allItems
      return
    $scope.items = filterFilter($scope.allItems, { category_name: type })
]