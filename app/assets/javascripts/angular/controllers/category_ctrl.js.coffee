Dweet.controller 'CategoryCtrl',
['$scope', '$http', '$routeParams', '$rootScope', '$filter', '$youtube', 'filterFilter', 'Video',
($scope, $http, $routeParams, $rootScope, $filter, $youtube, filterFilter, Video) ->

  $scope.selectedFilter = 'all'
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
      $scope.clip = filterFilter($scope.allItems, { id: getVideoId() })[0]
    else
      $scope.clip = $scope.allItems[0]

    if $scope.clip.is_playlist
      $scope.setPlaylist()
    else
      $scope.setVideo()

    $scope.addViewOnVideo($scope.clip)

  .error (data, status) ->
    alert 'Error'


  $scope.setPlaylist = () ->
    $youtube.videoId = null
    $youtube.videoPlaylist = null
    $youtube.playlist = $scope.clip.url

  $scope.setVideo = () ->
    $youtube.playlist = null
    $scope.setAllItemsIds()
    $youtube.videoId = $scope.allItemsIds[0]
    $youtube.videoPlaylist = $scope.allItemsIds

  $scope.setSelectedVideo = (video_id) ->
    video = $filter('filter')($scope.allItems, {id: video_id})[0]
    return if $scope.clip.id == video.id

    $scope.clip = video

    if $scope.clip.is_playlist
      $scope.setPlaylist()
    else
      $scope.setVideo()

    $youtube.loadPlayer()
    $scope.addViewOnVideo($scope.clip)

  $scope.$on 'youtube::ready', (e, youtube) ->
    if !$scope.clip.is_playlist
      index_video = $scope.allItemsIds.indexOf($scope.clip.url)
      $youtube.player.playVideoAt(index_video + 1)

  $scope.$on 'youtube::playing', (e, youtube) ->
    if $scope.clip.url != youtube.getCurrentVideoId() and !$scope.clip.is_playlist
      $scope.clip = $filter('filter')($scope.allItems, {url: youtube.getCurrentVideoId()})[0]
      $scope.addViewOnVideo($scope.clip)


  $scope.radioClipToRandom = () ->
    $scope.randomizeRadioClip = !$scope.randomizeRadioClip
    $youtube.player.setShuffle($scope.randomizeRadioClip)

  $scope.radioClipToRepeat = () ->
    $scope.repeatizeRadioClip = !$scope.repeatizeRadioClip
    $youtube.player.setLoop($scope.repeatizeRadioClip)

  getVideoId = () ->
    end_of_id = $routeParams['videoId'].indexOf('-')
    return $routeParams['videoId'].slice(0, end_of_id)

  $scope.addViewOnVideo = (video) ->
    Video.update { id: video.id, video: { view: video.view + 1 } }
    , success = (video) ->
      console.log 'success'
    , error = () ->
      console.log 'fail'

  $scope.setAllItemsIds = () ->
    $scope.allItemsIds = []
    videoItems = filterFilter($scope.items, { is_playlist: false })
    $filter('filter')(videoItems, (item) ->  return $scope.allItemsIds.push(item.url) )


  $scope.itemTypeFilter = (type) ->
    $scope.selectedFilter = type
    if type == 'all'
      $scope.items = $scope.allItems
      return
    $scope.items = filterFilter($scope.allItems, { category_name: type })
]
