angular.module('tourganizer').factory('keypressHelper', ['$parse', '$q', function keypress($parse, $q){
  var keysByCode = {
    8: 'backspace',
    9: 'tab',
    13: 'enter',
    27: 'esc',
    32: 'space',
    33: 'pageup',
    34: 'pagedown',
    35: 'end',
    36: 'home',
    37: 'left',
    38: 'up',
    39: 'right',
    40: 'down',
    45: 'insert',
    46: 'delete'
  };

  var modeNames = ['keydown', 'keyup', 'keypress'];

  return function(scope, elm) {
    if(typeof(scope) == 'undefined' || typeof(scope.keymap) == 'undefined') {
      return;
    }
    var params, combinations = [];
    var modes = _.keys(scope.keymap);

    scope.setKeymap = function(keymap) {
      return scope.keymap = keymap;
    };

    _.forEach(modeNames, function(name){ elm.unbind(name+".tourganizer") });

    _.forEach(modes, function(mode) {
      params = scope.keymap[mode];
      // Prepare combinations for simple checking
      angular.forEach(params, function (v, k) {
        var combination, expression;
        expression = $parse(v);

        angular.forEach(k.split(' '), function(variation) {
          combination = {
            expression: expression,
            keys: {}
          };
          angular.forEach(variation.split('-'), function (value) {
            combination.keys[value] = true;
          });
          combinations.push(combination);
        });
      });

      // Check only matching of pressed keys one of the conditions
      elm.bind(mode + ".tourganizer", function (event) {

        // No need to do that inside the cycle
        var altPressed = !!(event.metaKey || event.altKey);
        var ctrlPressed = !!event.ctrlKey;
        var shiftPressed = !!event.shiftKey;
        var keyCode = event.keyCode;

        // normalize keycodes
        if (mode === 'keypress' && !shiftPressed && keyCode >= 97 && keyCode <= 122) {
          keyCode = keyCode - 32;
        }

        // Iterate over prepared combinations
        angular.forEach(combinations, function (combination) {

          var mainKeyPressed = combination.keys[keysByCode[event.keyCode]] || combination.keys[event.keyCode.toString()];

          var altRequired = !!combination.keys.alt;
          var ctrlRequired = !!combination.keys.ctrl;
          var shiftRequired = !!combination.keys.shift;

          if (
            mainKeyPressed &&
            ( altRequired == altPressed ) &&
            ( ctrlRequired == ctrlPressed ) &&
            ( shiftRequired == shiftPressed )
          ) {
            // Run the function
            scope.$apply(function () {
              combination.expression(scope, { '$event': event });
            });
          }
        });
      });
    });
  };
}]);

angular.module('tourganizer').directive('tKeymap', ['keypressHelper', function(keypressHelper){
  return {
    link: function (scope, elm, attrs) {
      scope.$watch('keymap', function() {
        keypressHelper(scope, elm, attrs);
      });
    }
  };
}]);
