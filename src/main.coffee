enchant()
class Jubiol
  config : {
    WIDTH : 640,
    HEIGHT : 480,
    FPS : 30,
    IMAGE_PATH : 'resources/images/',
    IMAGES : [
      'miku.gif',
      'bullet.png',
      'bullet1.png',
      'font.png'
    ],
    SOUND_PATH : 'resources/sounds/',
    SOUNDS : [
    ],
  }
  constructor : ->
    @game = new Game @config.WIDTH, @config.HEIGHT
    @game.fps = @config.FPS
    @game.keybind(90, 'a')
    for image in @config.IMAGES
      @game.preload("#{@config.IMAGE_PATH}#{image}")

    @game.onload = ->
      @stage = new Stage()
      Jubiol.game.stage = @stage
      @rootScene.addChild @stage
    @game.start()
    Jubiol.game = @game
    Jubiol.config = @config

window.onload = ->
  new Jubiol()
