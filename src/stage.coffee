class Stage extends Group
  constructor : ->
    super
    player = new Player 138, 288
    @addChild player
    @addEventListener 'enterframe', @update
    @count = 0
  update : ->
    false
