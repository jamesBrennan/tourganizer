EditMixin = ['$scope','save_method','$window', ($scope, save_method, $window) ->
  $scope.parseDate = (stop) ->
    parts = stop.date.split("-")
    stop.date = new Date(parts[0], parts[1] - 1, parts[2])
    stop

  $scope.save = ->
    $scope.stop[save_method] (stop) ->
      $scope.parseDate(stop)
      $scope.$emit 'notify',
        type: 'info'
        message: 'Stop saved'
    , (error) ->
      $scope.$emit 'notify',
        type: 'error'
        message: 'error saving'

  $scope.addVenue = () ->
    name = $window.prompt("Venue or Contact name")
    if name
      $scope.stop.venues[name] = []

  $scope.venueNames = ->
    _.keys($scope.stop.venues)

  $scope.deleteVenue = (name) ->
    if $window.confirm('Are you sure?')
      $scope.stop.venues[name] = undefined
      $scope.save()

  $scope.venueProperties = (name) ->
    $scope.stop.venues[name]

  $scope.addProperty = (name) ->
    $scope.venueProperties(name).push( key: "", value: "" )

  $scope.deleteProperty = (name, index) ->
    $scope.stop.venues[name][index] = undefined
    $scope.save()
]

angular.module('stops').value 'EditMixin', EditMixin

Tourganizer.Stops.EditController = ['$scope', 'Stop', '$routeParams', '$injector', ($scope, Stop, $routeParams, $injector) ->
  Stop.get(id: $routeParams.id, (stop) ->
    $injector.invoke(EditMixin, @, $scope: $scope, save_method: '$update')
    $scope.stop = $scope.parseDate(stop)
    $scope.pageTitle = "#{$scope.stop.location}"
  )
]

Tourganizer.Stops.IndexController = ['Stop', '$scope', '$window', (Stop, $scope, $window) ->
  $scope.stops = Stop.query()
  $scope.destroy = (stop) ->
    if $window.confirm("Are you sure?")
      stop.$delete ->
        $scope.$emit 'notify', type: 'info', message: 'deleted'
]

Tourganizer.Stops.NewController = ['Stop', '$scope', '$window', '$injector', (Stop, $scope, $window, $injector) ->
  $scope.pageTitle = 'New Stop'
  $injector.invoke(EditMixin, @, $scope: $scope, save_method: '$save')
  $scope.stop = new Stop(venues: {})
]

angular.module('stops').controller 'StopIndexController', Tourganizer.Stops.IndexController
angular.module('stops').controller 'StopEditController', Tourganizer.Stops.EditController
angular.module('stops').controller 'StopNewController', Tourganizer.Stops.NewController
