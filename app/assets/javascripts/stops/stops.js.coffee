Tourganizer.Stops.EditController = ['$scope', 'Stop', '$routeParams', ($scope, Stop, $routeParams) ->
  $scope.stop = Stop.get($routeParams.id)
]

Tourganizer.Stops.IndexController = ['Stop', '$scope', (Stop, $scope) ->
  $scope.stops = Stop.query()
]

Tourganizer.Stops.NewController = ['Stop', '$scope', '$window', (Stop, $scope, $window) ->
  $scope.addVenue = () ->
    name = $window.prompt("Venue name")
    $scope.stop.venues[name] = []

  $scope.venueNames = ->
    _.keys($scope.stop.venues)

  $scope.venueProperties = (name) ->
    $scope.stop.venues[name]

  $scope.addProperty = (name) ->
    $scope.venueProperties(name).push( key: "", value: "" )

  $scope.save = ->
    $scope.stop.$save()

  $scope.stop = new Stop(venues: {})

  $scope.dateOptions = {
    changeYear: true,
    changeMonth: true,
    yearRange: '2013:-0'
  };

]

angular.module('stops').controller 'StopIndexController', Tourganizer.Stops.IndexController
angular.module('stops').controller 'StopEditController', Tourganizer.Stops.EditController
angular.module('stops').controller 'StopNewController', Tourganizer.Stops.NewController
