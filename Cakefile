{spawn, exec} = require 'child_process'
os = require 'os'

cmd = (name) ->
	if os.platform() is 'win32' then name + '.cmd' else name

npm = cmd 'npm'
brunch = cmd 'brunch'

assertDependencies = (globals, components, cb) ->
	done = 0
	notInstalled = []
	closeCb = (code) ->
		done++
		if done is components.length + 1
			# Exit unless all dependencies are installed.
			if notInstalled.length is 0
				cb()
			else
				console.error 'Missing ' + notInstalled.join(', ') + '; try:'
				console.error '  [sudo] npm -g install ' + globals.join(' ')
				console.error '  cake install'
				process.exit -1
	# Test if global dependencies are installed.
	list = ['brunch', 'forever', 'nodemon']
	npmList = spawn npm, ['-g', 'list'].concat(globals)
	npmList.stdout.on 'data', (data) ->
		for global in globals
			unless data.toString().indexOf(global) isnt -1
				notInstalled.push global
	npmList.on 'close', closeCb
	# Test if component dependencies are installed.
	for component in components
		npmList = spawn npm, ['list'], {cwd: component}
		npmList.stdout.on 'data', (data) ->
			if data.toString().indexOf('UNMET DEPENDENCY') isnt -1
				notInstalled.push component + ' dependencies'
		npmList.on 'close', closeCb

task 'install', 'Install dependencies', ->
	spawn npm, ['install'], {stdio: 'inherit'}

task 'update', 'Update dependencies', ->
	spawn npm, ['update'], {stdio: 'inherit'}

task 'build', 'Build application (production mode)', -> assertDependencies ['brunch'], ['.'], ->
	spawn brunch, ['build', '--env', 'production'], {stdio: 'inherit'}

task 'watch', 'Launch application (development mode)', -> assertDependencies ['brunch'], ['.'], ->
	spawn brunch, ['watch', '--server'], {stdio: 'inherit'}
