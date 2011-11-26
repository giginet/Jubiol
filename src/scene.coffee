class LogoScene extends Scene
  setup : ->
      @kawaz = new KawazSprite(253, 81)
      console.log "init"
      @kawaz.setImage 'kawaz.png'
      @kawaz.x = 193.5
      @kawaz.y = 220
      @kawaz.opacity = 0
      @addChild @kawaz
      @addEventListener 'enterframe', @update
      @timer = new Timer(180)
      @timer.setComplete ->
        Jubiol.game.replaceScene(new MainScene())
      @timer.play()
  update : ->
    @timer.tick()
    if @timer.now() < 60
      @kawaz.opacity += 1.0/60
    else if @timer.now() > 120
      @kawaz.opacity -= 1.0/60

class MainScene extends Scene
  constructor : ->
    super
    @setup()
  setup : ->
    @stage = new Stage()
    Jubiol.game.stage = @stage
    @addChild @stage
