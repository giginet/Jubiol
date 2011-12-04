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
  center : ->
    return new Vector(@x + @width / 2, @y + @height / 2)

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
      ++Jubiol.game.currentScene.counter.total
    else
      @setImage "bullet.png"
    @v.y = 10
  update : (e) ->
    super
    if @x < -50 or @x > Jubiol.config.WIDTH + 50 or @y -50 < 0 or @y > Jubiol.config.HEIGHT + 50
      Jubiol.game.stage.bullets.removeChild @

class Star
  constructor : (x, y, @max=10, @distance=20) ->
    rootPoint = new Vector(x, y)
    @direction = new Vector(1, 0)
    @direction.resize(@distance)
    @rotateCount = 0
    radius = @max * @distance / 2
    @centerPoint = rootPoint.clone().add(new Vector(radius, - radius * Math.tan(Math.PI / 10)))
    @currentPoint = rootPoint.clone()
    @bullets = []
  update : (red) ->
    unless @isComplete()
      vector = @currentPoint.add(@direction).clone()
      bullet = new Bullet(vector.x, vector.y, red)
      bullet.v = new Vector()
      @bullets.push bullet
      count = @bullets.length
      if count % @max is 0
        @direction.rotate(144)
        ++@rotateCount
      return bullet
    else
      if not @v?
        @v = Jubiol.game.stage.player.position().sub(@centerPoint).resize(7)
      @centerPoint.add(@v)
      for bullet in @bullets
        sub = bullet.center().sub(@centerPoint)
        rotated = sub.clone().rotate(5)
        bullet.v = @v.clone().add(rotated.sub(sub))
      @
    return false
  isComplete : () ->
    return @rotateCount >= 5
