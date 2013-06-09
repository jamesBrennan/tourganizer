Tourganizer.Stops.SaveMixin = ['$scope', 'save_method', ($scope, save_method) ->
  $scope.save = (stop, method) ->
    stop[method || save_method] ->
      $scope.$emit 'notify',
        type: 'info'
        message: 'Stop saved'
    , (error) ->
      $scope.$emit 'notify',
        type: 'error'
        message: 'error saving'
]
