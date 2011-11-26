class Stage extends Group
  constructor : ->
    super
    @player = new Player 138, 288
    @addChild @player
    @count = 0
    @total = 0
    @checkTimer = new Timer(45)
  start : ->
    @bullets = new Group()
    @addChild @bullets
    @addEventListener 'enterframe', @update
  update : (e) ->
    @checkTimer.tick()
    if not @checkTimer.isActive()
      @popEnemy()
      @player.update()
      for bullet in @bullets.childNodes.clone()
        bullet.update()
        if @player.within(bullet, 10)
          @checkTimer.play()
          break
    else if @checkTimer.isOver()
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
      @checkTimer.stop()
    else
      console.log "NG"
      label = new Label("Game Over")
      label.x = 150
      label.y = 200
      label.width = 500
      label.font = "64px #{Jubiol.config.FONT}"
      label.scaleX = 5
      label.scaleY = 5
      Jubiol.game.currentScene.addChild label
