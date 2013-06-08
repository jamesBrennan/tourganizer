Tourganizer.Stops.EditMixin = ['$scope', '$window', '$timeout', ($scope, $window, $timeout) ->
  $scope.addVenue = () ->
    name = $window.prompt("Venue or Contact name")
    if name
      $scope.stop.venues[name] = []

  $scope.venueNames = ->
    @names = _.keys($scope.stop.venues)

  $scope.changeName = (old_name, new_name) ->
    $scope.stop.venues[new_name] = $scope.stop.venues[old_name]
    $scope.stop.venues[old_name] = undefined
    $scope.save($scope.stop)

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

  $scope.showControls = ($event) ->
    $('> .control-group', $($event.target).parent('li:first')).css('visibility', 'visible')

  $scope.hideControls = ($event) ->
    $timeout =>
      $('> .control-group', $($event.target).parent('li:first')).css('visibility', 'hidden')
    , 200
]
