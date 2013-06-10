Tourganizer.Stops.SaveMixin = ['$scope', ($scope) ->
  $scope.save = (stop) ->
    method = if stop.id then '$update' else '$save'
    stop[method] ->
      $scope.$emit 'notify',
        type: 'info'
        message: 'Stop saved'
    , (error) ->
      $scope.$emit 'notify',
        type: 'error'
        message: 'error saving'
]
