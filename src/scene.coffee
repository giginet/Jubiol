class LogoScene extends Scene
  setup : ->
      @kawaz = new KawazSprite(253, 81)
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
  constructor : ->
    super
    @label = new Label "Jubiol"
    @label.font = "96px #{Jubiol.config.FONT}"
    @label.color = "#222"
    @label.x = 185
    @label.y = -50
    @addEventListener 'enterframe', @update
    @addChild @label
  update : ->
    unless @label.y >= 70
      @label.y += 3
    else if @label.y is 70
      play = new Label "Play"
      kawaz = new Label "Kawaz"
      play.x = 295
      play.y = 270
      play.font = "36px #{Jubiol.config.FONT}"
      kawaz.x = 280
      kawaz.y = 340
      kawaz.font = "36px #{Jubiol.config.FONT}"
      @addChild play
      @addChild kawaz

class MainScene extends Scene
  constructor : ->
    super
    @stateManager = new StateManager(new ReadyState(@))
    @stage = new Stage()
    Jubiol.game.stage = @stage
    @addChild @stage
    @counter = new Counter()
    @addEventListener 'enterframe', @update
  update : (e) ->
    state = @stateManager.currentState().update()
    if state is false
      @stateManager.popState()
    else if state isnt true
      @stateManager.pushState state
