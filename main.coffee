enchant()
window.onload = ->
  game = new Game 320, 320
  game.fps = 30
  game.preload('resources/images/miku.gif')

  game.onload = ->
    miku = new Sprite 44, 32
    miku.image = game.assets['resources/images/miku.gif']
    miku.x = 138
    miku.y = 288
    game.rootScene.addChild miku
  game.start()
