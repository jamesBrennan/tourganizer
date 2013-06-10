Tourganizer.Stops.EditController = ['$scope', 'Stop', '$routeParams', '$injector', ($scope, Stop, $routeParams, $injector) ->
  Stop.get(id: $routeParams.id, (stop) ->
    $injector.invoke(Tourganizer.Stops.EditMixin, @, $scope: $scope)
    $injector.invoke(Tourganizer.Stops.SaveMixin, @, $scope: $scope)
    $scope.stop = stop
    $scope.pageTitle = "#{$scope.stop.location}"
  )
  $injector.invoke(Tourganizer.Stops.EditHotkeysMixin, @, $scope: $scope)
]

angular.module('stops').controller 'StopEditController', Tourganizer.Stops.EditController
