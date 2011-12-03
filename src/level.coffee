class Level
  level : 0
  constructor : (stage) ->
    @stage = stage
  setup : ->
    ""
  teardown : ->
    ""
  update : ->
    ""
  isClear : ->
    false

class Level1 extends Level
  level : 1

