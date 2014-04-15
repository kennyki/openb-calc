{spawn} = require "child_process"
fs = require "fs"

# handle for windows..
isWindows = process.platform is "win32"
extension = if isWindows then ".cmd" else ""

# Currently rely on global modules..
# TODO: check why the local install of modules won't work in windows..
node = "node"
mocha = "mocha#{extension}"
dbPath = "./db"

option "-p", "--port [PORT_NUMBER]", "set the port number for `start`"
option "-e", "--environment [ENVIRONMENT_NAME]", "set the environment for `start`"

task "db", "init db structure", ->
	unless fs.existsSync dbPath
		fs.mkdirSync dbPath

task "start", "start the server", (options) ->
	invoke "db"
	process.env.NODE_ENV = options.environment ? "development"
	process.env.PORT = options.port if options.port
	spawn node, ["server.js"], stdio: "inherit"

task "test", "run the tests", ->
	invoke "db"
	process.env.NODE_ENV = "test"
	args = [
		"--compilers", "coffee:coffee-script"
		"--require", "./server"
		"--require", "should"
		"--reporter", "list"
		"--recursive"
		"./app/test"
	]
	spawn mocha, args, stdio: "inherit"