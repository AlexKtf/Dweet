Dweet.controller 'VideoCtrl', ['$scope', '$http', '$routeParams', '$sce', '$rootScope', ($scope, $http, $routeParams, $sce, $rootScope) ->
  $http.get('/videos/'+$routeParams['id']+'.json')
  .success (data, status) ->
    $scope.video = data
    if $scope.video.is_playlist
      $scope.url = $sce.trustAsResourceUrl('//www.youtube.com/embed/' + $scope.video.first_video_url + '?list=' + $scope.video.url)
    else
      $scope.url = $sce.trustAsResourceUrl('//www.youtube.com/embed/' + $scope.video.url)
    $rootScope.punchline = $scope.video.category.name
  .error (data, status) ->
    alert 'Error'

]