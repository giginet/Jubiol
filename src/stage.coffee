class Stage extends Group
  constructor : ->
    super
    @player = new Player 138, 288
    @addChild @player
    @bullets = new Group()
    @count = 0
    @total = 0
    @active = false
  start : ->
    @active = true
    @addEventListener 'enterframe', @update
    @addChild @bullets
  update : ->
    @popEnemy()
    @checkDeath()
  popEnemy : ->
    bullet = new Bullet(Math.random() * Jubiol.config.WIDTH, 0)
    if bullet.red
      ++Jubiol.game.stage.total
    @bullets.addChild bullet
  checkDeath : ->
    for bullet in @bullets.childNodes
      if @player.within(bullet, 10)
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
          Jubiol.game.currentScene.addChild label
