Tourganizer.Stops.IndexController = [
  'Stop', '$scope', '$window', '$injector', 'DB_DATE_FORMAT', 'DriveService', 'ScheduleService', '$q'
  (Stop, $scope, $window, $injector, DB_DATE_FORMAT, DriveService, ScheduleService, $q) ->

    $scope.stops = Stop.query () ->
      $scope.stoplist = $injector.instantiate(Tourganizer.Stops.StopList, scope: $scope, $injector: $injector)

    $scope.multi = new Tourganizer.Util.MultiSelect($scope.stops)
    $injector.invoke(Tourganizer.Stops.SaveMixin, @, $scope: $scope)
    $injector.invoke(Tourganizer.Stops.MultiSelectHotkeysMixin, @, $scope: $scope, multiselect: $scope.multi)

    $scope.destroy = (stops) ->
      if $window.confirm("Are you sure?")
        $scope.stoplist.remove(stops)
        locations = _.pluck stops, 'location'
        $q.all(_.map stops, (stop) -> stop.$delete()).then ->
          $scope.$emit 'notify', type: 'info', message: "#{locations.join(" and ")} deleted."

    addDay = (date_string, format = DB_DATE_FORMAT) ->
      moment(date_string, format).add('days', 1).format(format)

    subtractDay = (date_string, format = DB_DATE_FORMAT) ->
      moment(date_string, format).add('days', -1).format(format)

    dayAfter = (stop_index) ->
      addDay($scope.stops[stop_index].date)

    dayBefore = (stop_index) ->
      subtractDay($scope.stops[stop_index].date)

    $scope.focus = (stop) ->
      el = if stop.editing then 'input:first' else 'a:first'
      finder = [el, ".stop-#{stop.id || 'new'}"]
      watch_count = 0
      cancel_watch = $scope.$watch ->
        cancel_watch() if watch_count > 8 || $(finder...).length && $(finder...).focus()
        watch_count++

    $scope.addStop = (opts) ->
      { after_index, before_index } = opts

      date = if $scope.stops.length > 0
        if after_index
          dayAfter(after_index)
        else if before_index
          dayBefore(before_index)
        else
          dayAfter($scope.stops.length - 1)
      else
        Date.now()

      stop = new Stop(
        venues: {},
        editing: true
        date: date
      )

      splice_index = if after_index
          after_index + 1
        else if before_index
          before_index - 1

      if splice_index
        $scope.stops.splice(splice_index, 0, stop)
        $scope.stops[splice_index + 1]
      else
        $scope.stops.push stop
        _.last($scope.stops)

    $scope.shiftDates = (stops) ->
      days = window.prompt('How many days?')
      ScheduleService.nudgeDays stops, days

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

    $scope.$watch 'multi.cursor', (cursor) ->
      unless cursor == undefined
        $scope.focus($scope.stops[cursor])

    $scope.$watch 'stoplist.editing()', (editing) ->
      unless editing
        $scope.stoplist.cleanup() if $scope.stoplist
]

angular.module('stops').controller 'StopIndexController', Tourganizer.Stops.IndexController
