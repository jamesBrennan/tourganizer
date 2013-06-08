Tourganizer.NotificationDirective = ['$rootScope', '$timeout', ($rootScope, $timeout) ->
  template: "<div class='alert' ng-class='type' ng-show='show' ng-click='hide()'>{{message}}</div>"
  link: (scope, el) ->
    scope.show = false
    scope.hide = -> scope.show = false

    $rootScope.$on 'notify', (event, args) ->
      scope.type = args.type
      scope.message = args.message
      scope.show = true
      $timeout =>
        scope.hide()
      , 4000
]

angular.module('tourganizer').directive 'tNotification', Tourganizer.NotificationDirective;
