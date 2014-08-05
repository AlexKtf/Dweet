Dweet.directive 'titleLabel', ['$timeout', ($timeout) ->
  return {
    restrict: 'A',
    scope:
      item: '='
    ,
    templateUrl: 'title_label.html'
  }
]