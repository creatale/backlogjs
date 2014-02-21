#
# Application entry point.
#
Backlog = require 'models/backlog'
ListView = require 'views/list-view'

class Application
	constructor: ->
		window.onerror = @error
		@backlog = new Backlog BacklogDB
		@list()

	error: (message, file, line) ->
		$("body").prepend "<div class=\"alert alert-danger\"><b>Error!</b> " + message + "</div>"
		
	list: =>
		view = new ListView @backlog
		view.render()
		$('body').empty().append view.$el
		
$ -> new Application()
