exec = (require 'child_process').exec

FILENAME = 'jubiol'
FILES = [
  'main.coffee'
]

task 'compile', 'compile and minify JUBIOL.', (options) ->
  outputErr = (err, stdout, stderr) ->
    throw err if err
    console.log "#{stdout} #{stderr}"
  exec "coffee -cj #{FILES.join ' '} -o #{FILENAME}.js", outputErr
  exec "yuicompressor #{FILENAME}.js > #{FILENAME}.js", outputErr
