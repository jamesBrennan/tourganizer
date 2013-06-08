Tourganizer.Stops.SaveMixin = ['$scope', 'save_method', ($scope, save_method) ->
  $scope.parseDate = (stop) ->
    parts = stop.date.split("-")
    stop.date = new Date(parts[0], parts[1] - 1, parts[2])
    stop

  $scope.save = (stop, method) ->
    stop[method || save_method] (stop) ->
      $scope.parseDate(stop)
      $scope.$emit 'notify',
        type: 'info'
        message: 'Stop saved'
    , (error) ->
      $scope.$emit 'notify',
        type: 'error'
        message: 'error saving'
]
