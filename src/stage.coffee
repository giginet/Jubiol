class Stage extends Group
  constructor : ->
    super
    @player = new Player 138, 288
    @bullets = new Group()
    @addChild @player
    @addChild @bullets
    @addEventListener 'enterframe', @update
    @count = 0
    @total = 0
  update : ->
    @popEnemy()
    for bullet in @bullets.childNodes
      if @player.within(bullet, 10)
        @checkDeath()
  popEnemy : ->
    bullet = new Bullet(Math.random() * Jubiol.config.WIDTH, 0)
    if bullet.red
      ++Jubiol.game.stage.total
    @bullets.addChild bullet
  checkDeath : ->
    rate = Math.abs(@total-@count)/@total
    console.log "#{@count} #{@total} #{rate}"
    if rate < 0.05
      console.log "OK"
    else
      console.log "NG"
      label = new Label("Game Over")
      label.x = 150
      label.y = 200
      label.width = 500
      label.font = "64px Osaka"
      label.scaleX = 5
      label.scaleY = 5
      @addChild label

