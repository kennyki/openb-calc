{spawn} = require 'child_process'

# handle for windows..
extension = if process.platform is "win32" then ".cmd" else ""

# Currently rely on global modules..
# TODO: check why the local install of modules won't work in windows..
node = "node"
mocha = "mocha#{extension}"

option '-p', '--port [PORT_NUMBER]', 'set the port number for `start`'
option '-e', '--environment [ENVIRONMENT_NAME]', 'set the environment for `start`'
task 'start', 'start the server', (options) ->
  process.env.NODE_ENV = options.environment ? 'development'
  process.env.PORT = options.port if options.port
  spawn "node", ['server.js'], stdio: 'inherit'

task 'test', 'run the tests', ->
  process.env.NODE_ENV = 'test'
  args = [
    '--compilers', 'coffee:coffee-script'
    '--require', './server'
    '--require', 'should'
    '--reporter', 'list'
    '--recursive'
    './app/test'
  ]
  spawn mocha, args, stdio: 'inherit'