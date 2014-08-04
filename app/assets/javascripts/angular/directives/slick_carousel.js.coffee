Dweet.directive 'slickCarousel', ['$timeout', ($timeout) ->
  return link: ($scope, element, attr) ->
    $timeout () ->
      $(element).slick
        infinite: true,
        speed: 300,
        slidesToShow: 3,
        slidesToScroll: 1,
        responsive: [
          breakpoint: 600,
          settings:
            slidesToShow: 2,
            slidesToScroll: 2,
          ,
          breakpoint: 480,
          settings:
            slidesToShow: 1,
            slidesToScroll: 1
        ]
    , 0
]