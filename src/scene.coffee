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
    if Jubiol.game.input.a
      Jubiol.game.replaceScene(new MainScene())
    @timer.tick()
    if @timer.now() < 60
      @kawaz.opacity += 1.0/60
    else if @timer.now() > 120
      @kawaz.opacity -= 1.0/60

class TitleScene extends Scene
  false

class MainScene extends Scene
  constructor : ->
    super
    @timer = new Timer(600)
    @setup()
  setup : ->
    @stage = new Stage()
    Jubiol.game.stage = @stage
    @addChild @stage
    @addEventListener 'enterframe', @update
    @label = new Label('AAAAA')
    @timer.play()
  update : (e) ->
    @timer.tick()
    if @timer.now() is 30
      @label.text = 'Ready'
      @label.x = 220
      @label.y = 200
      @label.font = "64px #{Jubiol.config.FONT}"
      @addChild @label
    else if @timer.now() is 60
      @label.text = "GO!"
      @label.x = 250
      @stage.start()
    else if 60 < @timer.now() < 120
      @label.y -= 30
      if @label.y < -100
        @removeChild @label

