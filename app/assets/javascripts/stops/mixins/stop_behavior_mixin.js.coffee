Tourganizer.Stops.StopBehaviorMixin = (stop) ->
  stop.select = -> @selected = true
  stop.deselect = -> @selected = false
  stop.toggleSelection = -> @selected = !@selected

  stop.mark = -> @marked = true
  stop.unmark = -> @marked = false
  stop.toggleMarked = -> @marked = !@marked

  stop._revert = ->
    if @dirty
      _.extend @, @_clean_state
    @dirty = false

  stop._set_revert_state = ->
    @dirty = true
    @_clean_state = _.clone(@)

  stop.edit = ->
    @_set_revert_state()
    @editing = true

  stop.cancelEdit = ->
    @_revert()
    @editing = false

  stop.toggleEdit = ->
    if @editing then @cancelEdit() else @edit()
