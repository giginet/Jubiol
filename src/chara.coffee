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
    @v.set 5, 0
  update : (e) ->
    super
    if @x > Jubiol.config.WIDTH - @width
      @v.x = -5
    else if @x < 0
      @v.x = +5
