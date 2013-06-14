class Tourganizer.Util.MultiSelect
  constructor: (@root, @list) ->
    if @_pos(@root) < 0
      throw new Error("MultiSelect: root must be a member of list.")
    @reset(@root)

  reset: (@root) ->
    @selected = []
    @include(@root, false)

  include: (el, enforce_adjacency = true) ->
    pos = @_pos(el)

    throw new Error("MultiSelect: included element must be member of list.") if pos < 0
    return false if enforce_adjacency and not @_isAdjacent(pos)

    el.selected = true
    @selected[pos] = el
    @cursor = pos
    @selected

  exclude: (el) ->
    pos = @_pos(el)
    upper = @_is_upper(pos)
    lower = @_is_lower(pos)
    return false unless upper or lower
    el.selected = false
    if upper
      @selected.pop()
      @cursor = @_upper_index()
    else
      @selected.shift()
      @cursor = @_lower_index()
    @selected

  moveCursorTo: (index) ->
    el = @list[index]
    upper = @_upper_index()
    lower = @_lower_index()
    if el.selected
      if index == upper - 1
        @exclude(@selected[upper])
      else
        @exclude(@selected[lower])
    else
      @include(el)

  _pos: (el) ->
    @list.indexOf(el)

  _isAdjacent: (pos) ->
    pos - 1 == @_upper_index() || pos + 1 == @_lower_index()

  _upper_index: ->
    @selected.length - 1

  _lower_index: ->
    occupied = _.filter @selected, (el) -> el
    @selected.indexOf(_.first occupied)

  _is_upper: (index) ->
    @_upper_index() == index

  _is_lower: (index) ->
    @_lower_index() == index
