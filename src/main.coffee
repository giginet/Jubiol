enchant()
class Jubiol
  config : {
    WIDTH : 320,
    HEIGHT : 320,
    FPS : 30,
    IMAGE_PATH : 'resources/images/',
    IMAGES : [
      'miku.gif'
    ],
    SOUND_PATH : 'resources/sounds/',
    SOUNDS : [
    ],
  }
  constructor : ->
    @game = new Game @config.WIDTH, @config.HEIGHT
    @game.fps = @config.FPS
    for image in @config.IMAGES
      @game.preload("#{@config.IMAGE_PATH}#{image}")

    @game.onload = ->
      miku = new Miku 138, 288
      @rootScene.addChild miku
    @game.start()
    Jubiol.game = @game
    Jubiol.config = @config

window.onload = ->
  new Jubiol()
