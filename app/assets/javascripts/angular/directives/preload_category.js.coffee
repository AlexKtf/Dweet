Dweet.directive 'preloadCategory', ->
  link: (scope, element, attrs) ->
    scope.categories = JSON.parse(attrs.categories)
    element.remove()
