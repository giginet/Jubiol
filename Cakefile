sys = require 'sys'
exec = (require 'child_process').exec

FILENAME = 'jubiol'
FILES = [
  'kwing/lib/vector.coffee',
  'kwing/lib/array.coffee',
  'kwing/lib/timer.coffee',
  'kwing/lib/jukebox.coffee',
  'src/main.coffee',
  'src/sprite.coffee',
  'src/player.coffee',
  'src/bullet.coffee',
  'src/state.coffee',
  'src/level.coffee',
  'src/stage.coffee',
  'src/scene.coffee'
]
HTMLFILE = 'index.html'

task 'compile', 'compile and minify Jubiol.', (options) ->
  outputErr = (err, stdout, stderr) ->
    throw err if err
    if stdout or stderr
      console.log "#{stdout} #{stderr}"
  if FILES.length is 1
    exec "coffee -c #{FILENAME}.js #{FILES[0]}", outputErr
  else
    exec "coffee -cj #{FILENAME} #{FILES.join ' '}", outputErr 
  exec "yuicompressor #{FILENAME}.js > #{FILENAME}.min.js", outputErr
