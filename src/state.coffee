class StateManager
  constructor : (rootState) ->
    @stack = []
    @pushState rootState
  pushState : (state) ->
    state?.setup()
    @stack.push state
  popState : ->
    state = @stack.pop()
    state.teardown()
    return state
  replaceState : (state) ->
    @popState()
    @pushState state
  currentState : () ->
    return @stack.last()

class State
  """
  """
  constructor : (@scene=Jubiol.game.currentScene) ->
    ""
  setup : ->
    @
  teardown : ->
    @
  update : ->
    true

class ReadyState extends State
  setup : ->
    @timer = new Timer 600
    @label = new Label ''
    @timer.play()
  update : ->
    @timer.tick()
    if @timer.now() is 30
      @label.text = 'Ready'
      @label.x = 220
      @label.y = 200
      @label.font = "64px #{Jubiol.config.FONT}"
      @scene.addChild @label
    else if @timer.now() is 60
      @scene.removeChild @label
      return new MainState(@scene)
    return true

class MainState extends State
  constructor : ->
    super
    @stage = @scene.stage
    @stage.changeLevel 1
  setup : ->
    label = new Label ''
    label.text = 'Go'
    label.font = "64px #{Jubiol.config.FONT}"
    label.x = 270
    label.y = 200
    label.addEventListener 'enterframe', ->
      @y -= 30
      if @y < 0
        @parentNode.removeChild @
    @scene.addChild label

  update : ->
    @scene.counter.update()
    if @scene.stage.update()
      return new CheckState()
    return true

class CheckState extends State
  setup : ->
    @checkTimer = new Timer(45)
    @checkTimer.play()
  update : ->
    @scene.counter.update()
    @checkTimer.tick()
    if @checkTimer.isOver()
      return @checkDeath()
    return true
  checkDeath : ->
    rate = @scene.counter.calcRate()
    if rate < 0.05
      console.log "OK"
      @scene.stage.player.invincibleTimer.play()
      return false
    else
      console.log "NG"
      return new GameOverState()

class GameOverState extends State
  setup : ->
    gameover = new Label("Game Over")
    gameover.x = 150
    gameover.y = 200
    gameover.width = 500
    gameover.scaleX = 5
    gameover.scaleY = 5
    replay = new Label("Replay(z)")
    title = new Label("Title(x)")
    replay.x = 180
    replay.y = 300
    title.x = 350
    title.y = 300
    for label in [replay, title, gameover]
      label.font = "32px #{Jubiol.config.FONT}"
      @scene.addChild label
    gameover.font = "64px #{Jubiol.config.FONT}"
  update : ->
    if Jubiol.game.input.a
      Jubiol.game.replaceScene(new MainScene())
    else if Jubiol.game.input.b
      Jubiol.game.replaceScene(new TitleScene())
    return true

