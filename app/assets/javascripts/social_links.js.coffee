angular.module 'socialLinks', []
  .factory 'socialLinker', ['$window', '$location', ($window, $location) ->
    (urlFactory) ->
      (scope, element, attrs) ->
        currentUrl = attrs.customUrl || $location.absUrl()
        url = urlFactory(scope, currentUrl)

        popupWinAttrs = "
          status=no,
          width=#{scope.socialWidth || 640},
          height=#{scope.socialWidth || 480},
          resizable=yes,
          toolbar=no,
          menubar=no,
          scrollbars=no,
          location=no,
          directories=no
        "

        if element[0].nodeName == 'A' && (!attrs.href? || attrs.href == '')
          element.attr('href', url)

        element.attr('rel', 'nofollow')

        handler = (e)->
          e.preventDefault()
          url = urlFactory(scope, currentUrl)
          win = $window.open(
            url,
            'popupwindow',
            popupWinAttrs
          ).focus()

        element.on 'click', handler

        scope.$on '$destroy', ->
          element.off 'click', handler
  ]

  .directive 'socialFacebook', ['socialLinker', (linker) ->
    restrict: 'ACEM'
    scope: true
    link: linker (scope, url) ->
      shareUrl = ["https://facebook.com/sharer.php?"]
      shareUrl.push("u=#{encodeURIComponent(url)}")

      shareUrl.join('')
  ]

  .directive 'socialTwitter', ['socialLinker', (linker) ->
    restrict: 'ACEM'
    scope:
      status: '@status'
    link: linker (scope, url) ->
      scope.status ||= "Check this out! - #{url}"
      "https://twitter.com/intent/tweet?text=#{encodeURIComponent(scope.status)}"
  ]

  .directive 'socialGplus', ['socialLinker', (linker) ->
    restrict: 'ACEM'
    scope: true
    link: linker (scope, url) ->
      "https://plus.google.com/share?url=#{encodeURIComponent(url)}"
  ]
