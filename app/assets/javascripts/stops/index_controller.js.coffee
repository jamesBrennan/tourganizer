Tourganizer.Stops.IndexController = ['Stop', '$scope', '$window', '$injector', (Stop, $scope, $window, $injector) ->
  $scope.stops = Stop.query()

  $injector.invoke(Tourganizer.Stops.SaveMixin, @, $scope: $scope, save_method: '$update')

  $scope.destroy = (stop) ->
    if $window.confirm("Are you sure?")
      stop.$delete ->
        $scope.$emit 'notify', type: 'info', message: 'deleted'

  $scope.addStop = () ->
    $scope.stops.push(new Stop(venues: {}, editing: true))

  $scope.edit = (stop) ->
    stop.date = new Date(stop.date)
    stop.editing = true

  $scope.listSave = (stop) ->
    method = if stop.id then '$update' else '$save'
    $scope.save(stop, method)

  $scope.cancel = (stop) ->
    stop.editing = false
]

angular.module('stops').controller 'StopIndexController', Tourganizer.Stops.IndexController
