Dweet.directive 'youtubeVideo', ['$youtube', '$window', '$rootScope', ($youtube, $window, $rootScope) ->
  return {
    restrict: 'EA',
    link: (scope, element, attrs) ->

      $youtube.playerId = element[0].id
      
      if $youtube.ready
        $youtube.loadPlayer()

  }
]