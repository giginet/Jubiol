class Level
  level : 0
  constructor : (@stage) ->
    @
  setup : ->
    @
  teardown : ->
    @
  getBullet : ->
    bullet = new Bullet(Math.random() * Jubiol.config.WIDTH, 0)
  popEnemy : (bullets) ->
    bullet = @getBullet()
    if bullet.red
      ++Jubiol.game.stage.total
    bullets.addChild bullet
  isClear : ->
    false

class Level1 extends Level
  level : 1

