Tourganizer.Stops.EditMixin = ['$scope', '$window', ($scope, $window) ->
  $scope.addVenue = () ->
    name = $window.prompt("Venue or Contact name")
    if name
      $scope.stop.venues[name] = []

  $scope.venueNames = ->
    _.keys($scope.stop.venues)

  $scope.deleteVenue = (name) ->
    if $window.confirm('Are you sure?')
      $scope.stop.venues[name] = undefined
      $scope.save($scope.stop)

  $scope.venueProperties = (name) ->
    $scope.stop.venues[name] ?= []

  $scope.addProperty = (name) ->
    $scope.venueProperties(name).push( key: "", value: "" )

  $scope.deleteProperty = (name, index) ->
    $scope.stop.venues[name][index] = undefined
    $scope.save($scope.stop)
]
