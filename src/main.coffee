enchant()
class Jubiol extends Game
  config : {
    WIDTH : 640,
    HEIGHT : 480,
    FPS : 30,
    FONT : 'Helvetica',
    IMAGE_PATH : 'resources/images/',
    IMAGES : [
      'player.png',
      'bullet.png',
      'bullet1.png',
      'kawaz.png'
    ],
    SOUND_PATH : 'resources/sounds/',
    SOUNDS : [
      'count0.wav',
      'count1.wav',
      'count2.wav',
      'count3.wav',
      'count4.wav',
      'count5.wav',
      'count6.wav',
      'bomb.wav',
      'beep.wav',
    ],
    INITIAL_LEVEL : 7,
    LAST_LEVEL : 7,
    LEVEL_TIME : 30
  }
  constructor : ->
    super @config.WIDTH, @config.HEIGHT
    @.fps = @config.FPS
    @.keybind(90, 'a')
    @.keybind(88, 'b')
    Jubiol.game = @
    Jubiol.config = @config
    for image in @config.IMAGES
      @.preload("#{@config.IMAGE_PATH}#{image}")

    root = new LogoScene()
    @.onload = ->
      root.setup()
      @pushScene root
    @.start()

window.onload = ->
  new Jubiol()
