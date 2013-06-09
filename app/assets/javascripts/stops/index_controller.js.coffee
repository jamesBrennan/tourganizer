Tourganizer.Stops.IndexController = ['Stop', '$scope', '$window', '$injector', 'DB_DATE_FORMAT',
  (Stop, $scope, $window, $injector, DB_DATE_FORMAT) ->
    $scope.stops = Stop.query()

    $injector.invoke(Tourganizer.Stops.SaveMixin, @, $scope: $scope, save_method: '$update')
    $injector.invoke(Tourganizer.Stops.IndexHotkeysMixin, @, $scope: $scope)

    $scope.destroy = (stop) ->
      if $window.confirm("Are you sure?")
        stop.$delete ->
          $scope.stops.pop()
          $scope.$emit 'notify', type: 'info', message: 'deleted'

    addDay = (date_string, format = DB_DATE_FORMAT) ->
      moment(date_string, format).add('days', 1).format(format)

    $scope.selected = () ->
      _.find $scope.stops, (stop) -> stop.selected

    $scope.before = (stop) ->
      index = $scope.stops.indexOf(stop)
      return null if index == 0
      $scope.stops[index-1]

    $scope.after = (stop) ->
      index = $scope.stops.indexOf(stop)
      return null if index == $scope.stops.length - 1
      $scope.stops[index+1]

    $scope.addStop = () ->
      stop = new Stop(
        venues: {},
        editing: true
        date: addDay(_.last($scope.stops).date)
      )
      $scope.stops.push stop
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
