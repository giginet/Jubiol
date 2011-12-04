class Level
  level : 0
  constructor : (@stage) ->
    @popRate = @level * 0.08
    @redRate = @level * 0.03
  isPop : ->
    return Math.random() < @popRate
  setup : ->
    @
  teardown : ->
    @
  getBullet : (red) ->
    bullet = new Bullet(Math.random() * Jubiol.config.WIDTH - 32, 0, red)
  popEnemy : (bullets) ->
    return if not @isPop()
    red = Math.random() < @redRate
    bullet = @getBullet(red)
    if bullet.red
      ++Jubiol.game.currentScene.counter.total
    bullets.addChild bullet
  isClear : ->
    false

class Level1 extends Level
  level : 1

class Level2 extends Level
  level : 2
  getBullet : (red) ->
    bullet = super
    bullet.v = @stage.player.position().sub(bullet.position()).resize(bullet.speed)
    return bullet

class Level3 extends Level
  level : 3
  getBullet : (red) ->
    bullet = super
    player = @stage.player
    bullet.addEventListener 'enterframe', ->
      @v = player.position().sub(@position()).resize(@speed)
      @v.x *= 0.2
      @v.y = 3
      @update
    return bullet

class Level4 extends Level
  level : 4
  constructor : (@stage) ->
    super
    @max = 30
    @popCount = 0
    @count = 0
    @radius = 50
    @bullets = []
  isPop : ->
    ++@popCount
    @popCount %= 4
    return @popCount is 0
  getBullet : (red) ->
    if @count is 0
      x = Math.random() * (Jubiol.config.WIDTH - 200) + 100
      y = Math.random() * (Jubiol.config.HEIGHT - 200) + 100
      @centerPoint = new Vector(x, y)
      max = @max
      @bullets.each (bullet, i) ->
        bullet.v = new Vector(1, 0)
        bullet.v = bullet.v.rotate(i * 360 / max).resize(bullet.speed / 2)
      @bullets.clear()
    bullet = super
    @bullets.push bullet
    vector = new Vector(1, 0)
    vector.resize(@radius).rotate(360 / @max * @count).add(@centerPoint)
    bullet.x = vector.x
    bullet.y = vector.y
    bullet.v = new Vector()
    ++@count
    @count %= @max
    return bullet

class Level5 extends Level
  level : 5
  constructor : (@stage) ->
    super
    @popCount = 0
    @stars = []
  isPop : ->
    ++@popCount
    @popCount %= 3
    return @popCount is 0
  popEnemy : (bullets) ->
    red = Math.random() < @redRate
    if @stars.isEmpty() or @stars.last().isComplete?()
      x = Math.random() * (Jubiol.config.WIDTH - 400) + 200
      y = Math.random() * (Jubiol.config.HEIGHT - 400) + 200
      max = Math.floor(Math.random() * 8 + 4)
      distance = Math.random() * 10 + 15
      star = new Star(x, y, max, distance)
      @stars.push star
    for star in @stars
      continue if not star.isComplete() and not @isPop()
      bullet = star.update(red)
      if bullet isnt false
        bullets.addChild bullet
