Tourganizer.Stops.Helper = ->

  drive: (args) ->
    {from, to} = args
    _.find from.drives, (drive) ->
      drive.origin_id == from.id && drive.destination_id == to.id

angular.module('stops').service 'StopsHelper', Tourganizer.Stops.Helper
