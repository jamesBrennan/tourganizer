class Tourganizer.Util.MultiSelect
  constructor: (@root_member, @list) ->

  moveTo: (member) ->
    idx = @selected.indexOf(member)
    if idx && member != @root_member
      @selected.splice(idx, 1)
      member.selected = false
    else
      @selected.push member
      member.selected = true


