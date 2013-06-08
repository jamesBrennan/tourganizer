Tourganizer.Stops.EditController = ['$scope', 'Stop', '$routeParams', '$injector', ($scope, Stop, $routeParams, $injector) ->
  Stop.get(id: $routeParams.id, (stop) ->
    $injector.invoke(Tourganizer.Stops.EditMixin, @, $scope: $scope)
    $injector.invoke(Tourganizer.Stops.SaveMixin, @, $scope: $scope, save_method: '$update')
    $scope.stop = $scope.parseDate(stop)
    $scope.pageTitle = "#{$scope.stop.location}"
  )
]

angular.module('stops').controller 'StopEditController', Tourganizer.Stops.EditController