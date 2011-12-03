class KawazSprite extends Sprite
  constructor: (w, h, x=0, y=0) ->
    super w, h
    @removeEventListener 'enterframe'
    @x = x
    @y = y
    @v = new Vector()
    @speed = 7
  update : (e) ->
    @x += @v.x
    @y += @v.y
  setImage : (fileName) ->
    @image = Jubiol.game.assets["#{Jubiol.config.IMAGE_PATH}#{fileName}"]
  position : ->
    return new Vector(@x, @y)

class Player extends KawazSprite
  constructor: (x=0, y=0) ->
    super 42, 32, x, y
    @setImage 'miku.gif'
    @invincibleTimer = new Timer(45)
    @invincibleTimer.setComplete ->
      @stop()
  update : (e) ->
    @invincibleTimer.tick()
    @opacity = 0.5 + 0.5 * Math.cos(@invincibleTimer.now() * 30 * Math.PI / 180)
    @v.set 0, 0
    if Jubiol.game.input.left
      @v.x = -1
    else if Jubiol.game.input.right
      @v.x = 1
    if Jubiol.game.input.up
      @v.y = -1
    else if Jubiol.game.input.down
      @v.y = 1
    @v.resize @speed
    super
    if @x > Jubiol.config.WIDTH - @width
      @x = Jubiol.config.WIDTH - @width
    else if @x < 0
      @x = 0
    if @y > Jubiol.config.HEIGHT - @height
      @y = Jubiol.config.HEIGHT - @height
    else if @y < 0
      @y = 0

class Bullet extends KawazSprite
  constructor : (x=0, y=0, @red=false) ->
    super 12, 12, x, y
    if @red
      @setImage "bullet1.png"
    else
      @setImage "bullet.png"
    @v.y = 10
  update : (e) ->
    super
    if @x < 0 or @x > Jubiol.config.WIDTH or @y < 0 or @y > Jubiol.config.HEIGHT
      Jubiol.game.stage.bullets.removeChild @
