Dweet.controller 'HomeCtrl', ['$scope', '$http', '$rootScope', ($scope, $http, $rootScope) ->
  $http.get('/categories.json')
    .success (data, status) ->
      $scope.categories = data[0]
      $scope.items = data[1]
    .error (data, status) ->
      alert 'Error'

  $rootScope.punchline = 'bass music pon de internet'

  $rootScope.previousUrl = () ->
    return $rootScope.oldUrl

  $rootScope.itemType = (item) ->
    if item.is_playlist
      return 'playlists'
    else
      return 'videos'
  
  $rootScope.$on '$locationChangeStart', (evt, absNewUrl, absOldUrl) ->
    $rootScope.oldUrl = absOldUrl
]