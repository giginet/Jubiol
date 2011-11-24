sys = require 'sys'
exec = (require 'child_process').exec

FILENAME = 'jubiol'
FILES = [
  'main.coffee'
]

task 'compile', 'compile and minify JUBIOL.', (options) ->
  outputErr = (err, stdout, stderr) ->
    throw err if err
    if stdout or stderr
      console.log "#{stdout} #{stderr}"
  if FILES.size is 1
    exec "coffee -c #{FILENAME}.js #{FILES[0]}", outputErr
  else
    exec "coffee -cj #{FILENAME} #{FILES.join ' '}", outputErr 
  exec "yuicompressor #{FILENAME}.js > #{FILENAME}.min.js", outputErr

