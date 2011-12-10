class Stage extends Group
  constructor : ->
    super
    @player = new Player Jubiol.config.WIDTH /2 - 16, 288
    @addChild @player
    @bullets = new Group()
    @addChild @bullets
  update : (e) ->
    @level?.popEnemy(@bullets)
    @level?.update()
    @player.update()
    @levelTimer?.tick()
    if @levelTimer?.isOver()
      if @level.level is Jubiol.config.LAST_LEVEL
        return new ClearState()
      @changeLevel @level.level + 1
      Sound.load("#{Jubiol.config.SOUND_PATH}levelup.wav", 'audio/wav').play()
    for bullet in @bullets.childNodes.clone()
      bullet.update()
      if @player.within(bullet, 10)
        if @player.invincibleTimer.isActive() 
          Sound.load("#{Jubiol.config.SOUND_PATH}metal.wav", 'audio/wav').play()
        else
          Sound.load("#{Jubiol.config.SOUND_PATH}bomb.wav", 'audio/wav').play()
          return new CheckState()
    return false
  changeLevel : (lv) ->
    return if lv > Jubiol.config.LAST_LEVEL
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
    @addChild label
    @levelTimer = new Timer(Jubiol.config.FPS * Jubiol.config.LEVEL_TIME)
    @levelTimer.play()
    for bullet in @bullets.childNodes
      if bullet.v.isZero()
        bullet.v = Jubiol.game.stage.player.center().sub(bullet.position()).resize(bullet.speed)

class Counter
  constructor : ->
    @count = 0
    @total = 0
    @pressA = false
    @countTimer = new Timer(30)
    @soundCount = 0
    @soundReverse = false
  update : ->
    @countTimer.tick()
    if @countTimer.isOver()
      @countTimer.stop()
      @soundCount = 0
    if Jubiol.game.input.a
      if not @pressA
        sound = Sound.load("#{Jubiol.config.SOUND_PATH}count#{@soundCount}.wav", 'audio/wav')
        sound.play()
        ++@count
        if @soundCount is 6
          @soundReverse = true
        else if @soundReverse and @soundCount is 0
          @soundReverse = false
        if @soundCount < 6 and not @soundReverse
          ++@soundCount
        else if @soundReverse and @soundCount > 0
          --@soundCount
        @countTimer.reset()
        @countTimer.play()
        @pressA = true
    else
      @pressA = false
  calcRate : ->
    if @total
      return Math.abs(@total-@count)/@total
    return 1
  calcScore : ->
    base = Jubiol.game.stage.level.level * 1000
    score = Math.round(base + @total * 100 - 200 * @calcRate())
    score = 0 if score < 0
    score *= 2 if @total isnt 0 and @total is @count
    return score
