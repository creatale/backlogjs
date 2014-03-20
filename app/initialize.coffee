Application = require 'application'

# Initialize the application on DOM ready event.
$ ->
	new Application
		controllerSuffix: '-controller'
		routes: require 'routes'
