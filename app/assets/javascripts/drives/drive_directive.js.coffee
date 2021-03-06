Tourganizer.Drives.DriveDirective = (DriveService) ->
  link: (scope) ->
    stop = scope.stop
    prev_stop = scope.stoplist.before(scope.stop)
    if stop.id && prev_stop
      scope.drives = DriveService.find_or_create(from: prev_stop, to: stop)

    scope.$on "stop#{stop.$$hashKey}-saved", (e, stop) ->
      scope.drives = DriveService.find_or_create(from: prev_stop, to: stop)

    scope.recalculate = ->
      scope.drives = DriveService.replace(from: prev_stop, to: stop)

Tourganizer.Drives.DriveDirective.$inject = ['DriveService']
angular.module('drives').directive 'tDrive', Tourganizer.Drives.DriveDirective
