Dweet.service '$youtube', ['$window', '$rootScope', ($window, $rootScope) ->

  $(window).load ->
    tag = document.createElement("script")
    tag.type = "text/javascript"
    tag.src = 'https://www.youtube.com/iframe_api'
    document.body.appendChild tag
    return

  service = {
    ready: false
    playerId: null
    player: null
    videoId: null
    videoPlaylist: null
    playerHeight: '390'
    playerWidth: '640'
    currentState: null

    createPlayer: () ->
      if this.playlist == null
        this.player = new YT.Player(this.playerId,
          height: this.playerHeight,
          width: this.playerWidth,
          videoId: this.videoId,
          playerVars:
            autoplay: true,
            playlist: this.videoPlaylist.toString()
          events:
            onReady: onPlayerReady,
            onStateChange: onPlayerStateChange
        )
      else
        this.player = new YT.Player(this.playerId,
          height: this.playerHeight,
          width: this.playerWidth,
          playerVars:
            autoplay: true,
            listType: 'playlist',
            list: this.playlist
          events:
            onReady: onPlayerReady,
            onStateChange: onPlayerStateChange
        )

    loadPlayer: () ->
      if this.ready && this.playerId && (this.videoId || this.playlist)
        if this.player && angular.isFunction(this.player.destroy)
          this.player.destroy()
        this.createPlayer()

    getCurrentVideoId: () ->
      if this.ready && this.playerId
        if this.videoId != null
          data = this.player.getVideoData()
          return data['video_id']
        else
          data = this.player.getPlaylistId()
          return data

  }

  applyBroadcast = (event) ->
    $rootScope.$apply () ->
      $rootScope.$broadcast(event, service)

  stateNames = {
    0: 'ended',
    1: 'playing',
    2: 'paused',
    3: 'buffering',
    5: 'queued'
  }

  eventPrefix = 'youtube::'

  onPlayerReady = (event) ->
    applyBroadcast(eventPrefix + 'ready')

  onPlayerStateChange = (event) ->
    state = stateNames[event.data]
    if !angular.isUndefined(state)
      applyBroadcast(eventPrefix + state)
    service.currentState = state

  $window.onYouTubeIframeAPIReady = () ->
    $rootScope.$apply () ->
      service.ready = true

  return service
]