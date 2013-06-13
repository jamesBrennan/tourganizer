Tourganizer.Stops.IndexController = ['Stop', '$scope', '$window', '$injector', 'DB_DATE_FORMAT', 'DriveService'
  (Stop, $scope, $window, $injector, DB_DATE_FORMAT, DriveService) ->

    $scope.stops = Stop.query () ->
      $scope.stoplist = new Tourganizer.Stops.StopList($scope)

    $injector.invoke(Tourganizer.Stops.SaveMixin, @, $scope: $scope)
    $injector.invoke(Tourganizer.Stops.StopsHotkeysMixin, @, $scope: $scope)

    $scope.destroy = (stop) ->
      if $window.confirm("Are you sure?")
        $scope.stoplist.remove(stop)
        stop.$delete ->
          $scope.$emit 'notify', type: 'info', message: 'deleted'

    addDay = (date_string, format = DB_DATE_FORMAT) ->
      moment(date_string, format).add('days', 1).format(format)

    $scope.selected = ->
      $scope.stoplist.selected()

    $scope.before = (stop) ->
      $scope.stoplist.before(stop)

    $scope.after = (stop) ->
      $scope.stoplist.after(stop)

    $scope.focus = (stop) ->
      el = if stop.editing then 'input:first' else 'a:first'
      finder = [el, ".stop-#{stop.id || 'new'}"]
      watch_count = 0
      cancel_watch = $scope.$watch ->
        cancel_watch() if watch_count > 8 || $(finder...).length && $(finder...).focus()
        watch_count++

    $scope.addStop = () ->
      stop = new Stop(
        venues: {},
        editing: true
        date: addDay(_.last($scope.stops).date)
      )
      $scope.stops.push stop
      _.last($scope.stops)

    $scope.enterEdit = (stop) ->
      stop.editing = true
      $scope.editing = true

    $scope.exitEdit = (stop) ->
      stop.editing = false
      $scope.editing = false

    $scope.edit = (stop) ->
      stop.date = new Date(stop.date)

    $scope.listSave = (stop) ->
      $scope.save(stop)

    $scope.$watch 'stoplist.editing()', (editing) ->
      unless editing
        $scope.stoplist.cleanup() if $scope.stoplist
]

angular.module('stops').controller 'StopIndexController', Tourganizer.Stops.IndexController
