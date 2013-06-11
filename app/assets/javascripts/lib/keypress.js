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

    scope.hotkeys_active = true;

    _.forEach(modeNames, function(name){ elm.unbind(name+".tourganizer") });

    _.forEach(modes, function(mode) {
      params = scope.keymap[mode];
      // Prepare combinations for simple checking
      angular.forEach(params, function (v, k) {
        var combination, expression;
        expression = $parse(v.fn);

        angular.forEach(k.split(' '), function(variation) {
          combination = {
            expression: expression,
            active_on_edit: v.active_on_edit,
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
            if(!scope.editing || combination.active_on_edit) {
              scope.$apply(function () {
                combination.expression(scope, { '$event': event });
              });
            }
          }
        });
      });
    });
  };
}]);

/**
 * Bind one or more handlers to particular keys or their combination
 * @param hash {mixed} keyBindings Can be an object or string where keybinding expression of keys or keys combinations and AngularJS Exspressions are set. Object syntax: "{ keys1: expression1 [, keys2: expression2 [ , ... ]]}". String syntax: ""expression1 on keys1 [ and expression2 on keys2 [ and ... ]]"". Expression is an AngularJS Expression, and key(s) are dash-separated combinations of keys and modifiers (one or many, if any. Order does not matter). Supported modifiers are 'ctrl', 'shift', 'alt' and key can be used either via its keyCode (13 for Return) or name. Named keys are 'backspace', 'tab', 'enter', 'esc', 'space', 'pageup', 'pagedown', 'end', 'home', 'left', 'up', 'right', 'down', 'insert', 'delete'.
 * @example <input ui-keypress="{enter:'x = 1', 'ctrl-shift-space':'foo()', 'shift-13':'bar()'}" /> <input ui-keypress="foo = 2 on ctrl-13 and bar('hello') on shift-esc" />
 **/
angular.module('tourganizer').directive('tKeymap', ['keypressHelper', function(keypressHelper){
  return {
    link: function (scope, elm, attrs) {
      scope.$watch('keymap', function() {
        keypressHelper(scope, elm, attrs);
      });
    }
  };
}]);
