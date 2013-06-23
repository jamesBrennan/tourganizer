Tourganizer.ScheduleService = (DB_DATE_FORMAT) ->
  nudgeDays: (stops, num_days) ->
    _.map stops, (stop) ->
      stop.date = moment(stop.date, DB_DATE_FORMAT).add 'days', num_days
      stop.$update()

Tourganizer.ScheduleService.$inject = ['DB_DATE_FORMAT']
angular.module('tourganizer').service 'ScheduleService', Tourganizer.ScheduleService
