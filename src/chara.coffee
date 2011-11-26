class KawazSprite extends Sprite
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
  setOpacity : (opacity) ->
    w = @image.width
    h = @image.height
    console.log "opacity"
    for x in [0...w]
      for y in [0...h]
        console.log @image.getPixel()
        pixel = @image.getPixel()
        @image.setPixel(x, y, pixel[0], pixel[1], pixel[2], opacity)

class Player extends KawazSprite
  constructor: (x=0, y=0) ->
    super 42, 32, x, y
    @setImage 'miku.gif'
    @speed = 7
    @pressA = false
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
    if Jubiol.game.input.a
      if !@pressA
        ++Jubiol.game.stage.count
        @pressA = true
        console.log Jubiol.game.stage.count
    else
      @pressA = false

class Bullet extends KawazSprite
  constructor : (x=0, y=0) ->
    super 12, 12, x, y
    rand = Math.random() * 100
    if rand < 5
      @setImage "bullet1.png"
      @red = true
    else
      @setImage "bullet.png"
      @red = false
  update : (e) ->
    @v.y = 10
    super
    if @x < 0 or @x > Jubiol.config.WIDTH or @y < 0 or @y > Jubiol.config.HEIGHT
      Jubiol.game.stage.bullets.removeChild @
