Tourganizer.PropertiesDirective = () ->
  scope:
    node: '=tProperties'
  link: (scope, el, attrs) ->

    Duple = (key, value) ->
      x = {}
      x[key] = value
      x

    $scope.attributes = _.keys($scope.node)

    $scope.addInfo = (node, name) ->
      node[name] = []

    $scope.addDuple = (array, name, value) ->
      array.push new Duple(name, value)
