Tourganizer.NotificationDirective = ['$rootScope', ($rootScope) ->
  template: "<div class='alert' ng-class='type' ng-show='show' ng-click='hide()'>{{message}}</div>"
  link: (scope, el) ->
    scope.show = false
    scope.hide = -> scope.show = false

    $rootScope.$on 'notify', (event, args) ->
      scope.type = args.type
      scope.message = args.message
      scope.show = true
]

angular.module('tourganizer').directive 'tNotification', Tourganizer.NotificationDirective;
