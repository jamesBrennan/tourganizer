Tourganizer.Stops.MultiSelectHotkeysMixin = ($scope, @multiselect) ->

  states =
    navigating:
      keyup: {}
      keypress:
        'up': @multiselect.selectPrev
        'down': @multiselect.selectNext
        'shift-up': @multiselect.moveToPrev
        'shift-down': @multiselect.moveToNext
        'alt-down': @multiselect.selectLast
        'alt-up': @multiselect.selectFirst
        '68': => #d
          $scope.destroy(_.compact @multiselect.selected)
        '83': => #s
          selected = _.compact @multiselect.selected
          els = if selected.length > 0 then selected else @multiselect.list
          $scope.shiftDates els
        '78': => #n
          @multiselect.reset $scope.addStop(after_index: @multiselect.cursor)
        'shift-78': =>
          @multiselect.reset $scope.addStop(before_index: @multiselect.cursor)
    editing:
        keyup: {}
        keypress: {}

  enterEdit = ->
    $scope.setKeymap states.editing

  exitEdit = ->
    $scope.setKeymap states.navigating

  $scope.keymap = states.navigating

  $scope.$watch 'stoplist.editing()', (editing) ->
    if editing
      enterEdit()
    else
      exitEdit()

Tourganizer.Stops.MultiSelectHotkeysMixin.$inject = ["$scope", "multiselect"]
