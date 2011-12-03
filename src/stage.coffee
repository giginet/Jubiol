class Stage extends Group
  constructor : ->
    super
    @player = new Player 138, 288
    @addChild @player
    @bullets = new Group()
    @addChild @bullets
  update : (e) ->
    @level?.popEnemy(@bullets)
    @player.update()
    for bullet in @bullets.childNodes.clone()
      bullet.update()
      if not @player.invincibleTimer.isActive() and @player.within(bullet, 10)
        return true
    return false
  changeLevel : (lv) ->
    levelClass = eval("Level#{lv}")
    @level = new levelClass(@)
    label = new Label "Level #{lv}"
    label.font = "32px #{Jubiol.config.FONT}"
    label.x = -50
    label.y = 440
    label.addEventListener 'enterframe', ->
      @x += 20
      if @x > Jubiol.config.WIDTH
        @parentNode.removeChild @
    console.log "new Level"
    @addChild label

class Counter
  constructor : ->
    @count = 0
    @total = 0
    @pressA = false
  update : ->
    if Jubiol.game.input.a
      if !@pressA
        ++@count
        @pressA = true
        console.log @count
    else
      @pressA = false
  calcRate : ->
    if @total
      return Math.abs(@total-@count)/@total
    return 1

