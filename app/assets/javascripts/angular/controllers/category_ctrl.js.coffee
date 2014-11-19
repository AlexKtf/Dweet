Dweet.controller 'CategoryCtrl',
['$scope', '$http', '$routeParams', '$rootScope', '$sce', '$filter', '$youtube', '$timeout', 'filterFilter', 'Video',
($scope, $http, $routeParams, $rootScope, $sce, $filter, $youtube, $timeout, filterFilter, Video) ->

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
    if $routeParams['videoId']?
      $scope.videoSelected = filterFilter($scope.allItems, { id: getVideoId() })[0]

    if $scope.videoSelected? and $scope.videoSelected.is_playlist
      $scope.setSelectedVideo($scope.videoSelected.id)
    else
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
    
    if $scope.videoSelected
      angular.forEach $scope.radioItems, (item, key) ->
        $scope.radioCurrentIndex = key if ($scope.videoSelected.id - item.id) == 0
      $scope.videoSelected = false

    $scope.clip = $scope.radioItems[$scope.radioCurrentIndex]
    $scope.alreadyPlayedInRandom.push($scope.radioCurrentIndex)
    $scope.addViewOnVideo($scope.clip)

  $scope.nextRadioClip = () ->
    if !$scope.randomizeRadioClip
      clip = $scope.getNextVideo()

      return $scope.automaticRepeatOrNot() if !clip?
      $scope.clip = clip
      $scope.addViewOnVideo($scope.clip)
    else
      return $scope.automaticRepeatOrNot() if $scope.alreadyPlayedInRandom.length == $scope.radioItems.length
      $scope.clip = $scope.getRandomAvalaibleVideo()
      $scope.addViewOnVideo($scope.clip)



  $scope.getRandomAvalaibleVideo = () ->
    $scope.randomNumber = Math.floor(Math.random()*$scope.radioItems.length) while $scope.alreadyPlayedInRandom.indexOf($scope.randomNumber) > -1
    $scope.alreadyPlayedInRandom.push($scope.randomNumber)
    return $scope.radioItems[$scope.randomNumber]

  $scope.getNextVideo = () ->
    $scope.radioCurrentIndex = $scope.radioCurrentIndex + 1
    return $scope.radioItems[$scope.radioCurrentIndex]

  $scope.automaticRepeatOrNot = () ->
    if $scope.repeatizeRadioClip
      $scope.radioClip = false
      $scope.setRadioClip()
    else
      $scope.letRepeatFlow = true

  $scope.setSelectedVideo = (video_id) ->
    selected = $filter('filter')($scope.allItems, {id: video_id})
    return if selected.length == 0
    if selected[0].is_playlist
      $scope.fullUrl = $sce.trustAsResourceUrl(selected[0].yt_url)
      $scope.playlist_title = selected[0].title
      $scope.addViewOnVideo(selected[0])
    else
      $scope.fullUrl = false
      $scope.radioClip = false
      $scope.videoSelected = selected[0]
      $scope.setRadioClip()
      $scope.addViewOnVideo($scope.clip)

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

  $scope.addViewOnVideo = (video) ->
    Video.update { id: video.id, video: { view: video.view + 1 } }
    , success = (video) ->
      console.log 'success'
    , error = () ->
      console.log 'fail'


  $scope.itemTypeFilter = (type) ->
    $scope.selectedFilter = type
    if type == 'all'
      $scope.items = $scope.allItems
      return
    $scope.items = filterFilter($scope.allItems, { category_name: type })
]