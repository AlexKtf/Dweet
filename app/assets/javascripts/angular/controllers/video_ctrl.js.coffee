Dweet.controller 'VideoCtrl', ['$scope', '$http', '$routeParams', '$sce', ($scope, $http, $routeParams, $sce) ->
  $http.get('/videos/'+$routeParams['id']+'.json')
  .success (data, status) ->
    $scope.video = data
    $scope.url = $sce.trustAsResourceUrl('//www.youtube.com/embed/' + $scope.video.url)
  .error (data, status) ->
    alert 'Error'
]