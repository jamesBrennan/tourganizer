Tourganizer.Stops.EditController = ['$scope', 'Stop', '$routeParams', ($scope, Stop, $routeParams) ->
  $scope.stop = Stop.get($routeParams.id)
]

Tourganizer.Stops.IndexController = ['Stop', '$scope', (Stop, $scope) ->
  Stop.query().$then (resp) ->
    $scope.stops = resp.data
]

angular.module('stops').controller 'StopIndexController', Tourganizer.Stops.IndexController
angular.module('stops').controller 'StopEditController', Tourganizer.Stops.EditController
