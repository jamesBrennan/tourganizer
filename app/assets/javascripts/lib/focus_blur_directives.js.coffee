angular.module('tourganizer').directive 'tFocus', ['$parse', ($parse) ->
  link: (scope, element, attr) ->
    fn = $parse attr['tFocus']
    element.bind 'focus', (event) ->
      scope.$apply ->
        fn scope, {$event: event}
]

angular.module('tourganizer').directive 'tBlur', ['$parse', ($parse) ->
  link: (scope, element, attr) ->
    fn = $parse attr['tBlur']
    element.bind 'blur', (event) ->
      scope.$apply ->
        fn scope, {$event: event}
]
