class StateManager
  constructor : ->
    @stack = []
  pushState : (@state) ->
    @stack.push @state
  popState : ->
    return @stack.pop()
  replaceState : (@state) ->
    @stack[-1] = @state
  currentState : () ->
    return @stack[-1]
class State
  """
  """
  constructor : (stage) ->
    @stage = stage
  setup : ->
    @
  teardown : ->
    @
  update : ->
    @
class ReadyState extends State
  @

class MainState extends State
  @

class CheckState extends State
  @
