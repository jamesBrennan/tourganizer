Tourganizer.Stops.EditController = ['$scope', 'Stop', '$routeParams', ($scope, Stop, $routeParams) ->
  $scope.stop = Stop.get($routeParams.id)
]

Tourganizer.Stops.IndexController = ['Stop', '$scope', '$window', (Stop, $scope, $window) ->
  $scope.stops = Stop.query()
  $scope.destroy = (stop) ->
    if $window.confirm("Are you sure?")
      stop.$delete ->
        $scope.$emit 'notify', type: 'info', message: 'deleted'
]

Tourganizer.Stops.NewController = ['Stop', '$scope', '$window', (Stop, $scope, $window) ->
  $scope.addVenue = () ->
    name = $window.prompt("Venue name")
    if name
      $scope.stop.venues[name] = []

  $scope.venueNames = ->
    _.keys($scope.stop.venues)

  $scope.venueProperties = (name) ->
    $scope.stop.venues[name]

  $scope.addProperty = (name) ->
    $scope.venueProperties(name).push( key: "", value: "" )

  $scope.save = ->
    $scope.stop.$save (stop) ->
      console.log 'success', arguments, $scope
      $scope.$emit 'notify',
        type: 'info'
        message: 'Stop saved'
    , (error) ->
      console.log 'error', arguments
      $scope.$emit 'notify',
          type: 'error'
          message: 'error saving'

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
