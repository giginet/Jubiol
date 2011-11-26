class Stage extends Group
  constructor : ->
    super
    @player = new Player 138, 288
    @addChild @player
    @count = 0
    @total = 0
    @checkTimer = new Timer(45)
    @gameover = false
  start : ->
    @bullets = new Group()
    @addChild @bullets
    @addEventListener 'enterframe', @update
    @pressA = false
  update : (e) ->
    return if @gameover
    @checkTimer.tick()
    if not @checkTimer.isActive()
      @popEnemy()
      @player.update()
      for bullet in @bullets.childNodes.clone()
        bullet.update()
        if not @player.invincibleTimer.isActive() and @player.within(bullet, 10)
          @checkTimer.play()
          break
    else if @checkTimer.isOver()
      @checkDeath()
    if Jubiol.game.input.a
      if !@pressA
        ++Jubiol.game.stage.count
        @pressA = true
        console.log Jubiol.game.stage.count
    else
      @pressA = false

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
      @player.invincibleTimer.play()
      @checkTimer.stop()
    else
      console.log "NG"
      @parentNode.removeEventListener 'enterframe'
      @gameover = true
      label = new Label("Game Over")
      label.x = 150
      label.y = 200
      label.width = 500
      label.font = "64px #{Jubiol.config.FONT}"
      label.scaleX = 5
      label.scaleY = 5
      Jubiol.game.currentScene.addChild label
