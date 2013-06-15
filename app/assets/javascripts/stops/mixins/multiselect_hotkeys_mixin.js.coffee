Tourganizer.Stops.MultiSelectHotkeysMixin = ($scope, @multiselect) ->

  select = (el) =>
    @multiselect.reset(el)

  functions =
    selectPrev: =>
      cursor = @multiselect.cursor
      if cursor? == false or cursor == 0
        select(_.last @multiselect.list)
      else
        select(@multiselect.list[cursor - 1])

    selectNext: =>
      cursor = @multiselect.cursor
      if cursor? == false or cursor == @multiselect.list.length - 1
        select(@multiselect.list[0])
      else
        select(@multiselect.list[cursor + 1])

    multiSelectPrev: =>
      @multiselect.moveCursorTo(@multiselect.cursor - 1)

    multiSelectNext: =>
      @multiselect.moveCursorTo(@multiselect.cursor + 1)

  states =
    navigating:
      keyup: {}
      keypress:
        'up': functions.selectPrev
        'down': functions.selectNext
        'shift-up': functions.multiSelectPrev
        'shift-down': functions.multiSelectNext
    editing:
      keyup: {}
      keypress: {}

  enterEdit = ->
    $scope.setKeymap states.editing

  exitEdit = ->
    $scope.setKeymap states.navigating

  $scope.multiselect_functions = functions
  $scope.keymap = states.navigating

  $scope.$watch 'stoplist.editing()', (editing) ->
    if editing
      enterEdit()
    else
      exitEdit()

Tourganizer.Stops.MultiSelectHotkeysMixin.$inject = ["$scope", "multiselect"]
