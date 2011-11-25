class Character extends Sprite
  constructor: (w, h, x=0, y=0) ->
    super w, h
    @addEventListener 'enterframe', @update
    @x = x
    @y = y
    @v = new Vector()
  update : (e) ->
    @x += @v.x
    @y += @v.y
  setImage : (fileName) ->
    @image = Jubiol.game.assets["#{Jubiol.config.IMAGE_PATH}#{fileName}"]

class Miku extends Character
  constructor: (x=0, y=0) ->
    super 42, 32, x, y
    @setImage 'miku.gif'
    @speed =7
  update : (e) ->
    @v.set 0, 0
    if Jubiol.game.input.left
      @v.x = -1
    else if Jubiol.game.input.right
      @v.x = 1
    if Jubiol.game.input.up
      @v.y = -1
    else if Jubiol.game.input.down
      @v.y = 1
    @v.truncate @speed
    super
    if @x > Jubiol.config.WIDTH - @width
      @x = Jubiol.config.WIDTH - @width
    else if @x < 0
      @x = 0
    if @y > Jubiol.config.HEIGHT - @height
      @y = Jubiol.config.HEIGHT - @height
    else if @y < 0
      @y = 0
