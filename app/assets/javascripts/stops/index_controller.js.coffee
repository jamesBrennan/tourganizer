Tourganizer.Stops.IndexController = ['Stop', '$scope', '$window', '$injector', (Stop, $scope, $window, $injector) ->
  $scope.stops = Stop.query()

  $injector.invoke(Tourganizer.Stops.SaveMixin, @, $scope: $scope, save_method: '$update')
  $injector.invoke(Tourganizer.Stops.IndexHotkeysMixin, @, $scope: $scope)

  $scope.destroy = (stop) ->
    if $window.confirm("Are you sure?")
      stop.$delete ->
        $scope.stops.pop()
        $scope.$emit 'notify', type: 'info', message: 'deleted'

  $scope.addStop = () ->
    last_date = _.last($scope.stops).date
    $scope.stops.push new Stop(venues: {}, editing: true)
    _.last($scope.stops).date = last_date
    _.last($scope.stops)

  $scope.edit = (stop) ->
    stop.date = new Date(stop.date)
    stop.editing = true

  $scope.listSave = (stop) ->
    method = if stop.id then '$update' else '$save'
    $scope.save(stop, method)

  $scope.cancel = (stop) ->
    unless stop.id
      index = $scope.stops.indexOf(stop)
      $scope.stops.splice(index, 1)
    stop.editing = false

]

angular.module('stops').controller 'StopIndexController', Tourganizer.Stops.IndexController
