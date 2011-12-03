enchant()
class Jubiol
  config : {
    WIDTH : 640,
    HEIGHT : 480,
    FPS : 30,
    FONT : 'Helvetica',
    IMAGE_PATH : 'resources/images/',
    IMAGES : [
      'miku.gif',
      'bullet.png',
      'bullet1.png',
      'font.png',
      'kawaz.png'
    ],
    SOUND_PATH : 'resources/sounds/',
    SOUNDS : [
    ],
    INITIAL_LEVEL : 1
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

    root = new LogoScene()

    @game.onload = ->
      root.setup()
      @pushScene root
    @game.start()

window.onload = ->
  new Jubiol()
