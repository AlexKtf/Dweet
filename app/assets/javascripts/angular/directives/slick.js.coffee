Dweet.directive 'slick', ['$timeout', ($timeout) ->
  return {
    restrict: 'A'
    link: ($scope, element, attrs) ->
      $timeout ()->
        $(element).slick
          dots: false
          infinite: false
          speed: 300
          slidesToShow: 3
          slidesToScroll: 1
          responsive: [
            {
              breakpoint: 1024
              settings:
                slidesToShow: 3
                slidesToScroll: 1
                infinite: true
                dots: true
            }
            {
              breakpoint: 600
              settings:
                slidesToShow: 2
                slidesToScroll: 1
            }
            {
              breakpoint: 480
              settings:
                slidesToShow: 1
                slidesToScroll: 1
            }
          ]
      , 100

  }
]
