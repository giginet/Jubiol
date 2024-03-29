class Player extends KawazSprite
  constructor: (x=0, y=0) ->
    super 32, 32, x, y
    @setImage 'player.png'
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
