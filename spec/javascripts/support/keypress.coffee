Tourganizer.keypress = (node, key) ->
  codesByKey =
    'backspace': 8,
    'tab': 9,
    'enter': 13,
    'esc': 27,
    'space': 32,
    'pageup': 33,
    'pagedown': 34,
    'end': 35,
    'home': 36,
    'left': 37,
    'up': 38,
    'right': 39,
    'down': 40,
    'insert': 45,
    'delete': 46

  pattern =
    modifiers: null
    key: null
  if key.indexOf('-')
    parts = key.split('-') 
    pattern.modifiers = _.filter key.split('-'), (key) -> key.match "ctrl|alt|shift"
    pattern.key = _.last parts
    
  key ?= pattern.key
  key = if codesByKey[key] then codesByKey[key] else key

  press = $.Event("keypress")
  press.ctrlKey   = _.include pattern.modifiers, 'ctrl'
  press.altKey    = _.include pattern.modifiers, 'alt'
  press.shiftKey  = _.include pattern.modifiers, 'shift'
  press.which     = key

  $(node).keypress(press)
