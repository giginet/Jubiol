enchant()
class Jubiol
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
    INITIAL_LEVEL : 1,
    LAST_LEVEL : 7,
    LEVEL_TIME : 30
  }
  constructor : ->
    @game = new Game @config.WIDTH, @config.HEIGHT
    @game.fps = @config.FPS
    @game.keybind(90, 'a')
    @game.keybind(88, 'b')
    Jubiol.game = @game
    Jubiol.config = @config
    for image in @config.IMAGES
      @game.preload("#{@config.IMAGE_PATH}#{image}")
    for sound in @config.SOUNDS
      @game.preload("#{@config.SOUND_PATH}#{sound}")
    root = new LogoScene()
    @game.onload = ->
      root.setup()
      @pushScene root
    @game.start()

window.onload = ->
  new Jubiol()
