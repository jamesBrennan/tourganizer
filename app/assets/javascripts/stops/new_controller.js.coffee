Tourganizer.Stops.NewController = ['Stop', '$scope', '$window', '$injector', (Stop, $scope, $window, $injector) ->
  $scope.pageTitle = 'New Stop'
  $injector.invoke(Tourganizer.Stops.EditMixin, @, $scope: $scope)
  $injector.invoke(Tourganizer.Stops.SaveMixin, @, $scope: $scope)
  $scope.stop = new Stop(venues: {})
]

angular.module('stops').controller 'StopNewController', Tourganizer.Stops.NewController
