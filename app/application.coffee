#
# Application entry point.
#
ListView = require 'views/list-view'
Backlog = require 'models/backlog'

calculateSprintStoryPoints = ->
	result = {}
	i = 0
	while i < Backlog.stories.length
		story = stories[i]
		sprint = story.sprint
		if sprint? and story.points?
			result[sprint] = 0  unless result[sprint]?
			result[sprint] += story.points  unless story.extra
		i++
	return result

countStoriesPerPriority = ->
	storiesPerPriority = {}
	i = 0
	while i < Backlog.stories.length
		story = stories[i]
		if story.priority?
			storiesPerPriority[story.priority] = []  unless storiesPerPriority[story.priority]?
			storiesPerPriority[story.priority].push story.id
		i++
	return storiesPerPriority

class Application
	constructor: ->
		window.onerror = @error
		@list()

	error: (message, file, line) ->
		$("body").prepend "<div class=\"alert alert-danger\"><b>Error!</b> " + message + "</div>"
		
	list: =>
		view = new ListView Backlog
		view.render()
		$('.container').empty().append view.$el
		
$ -> new Application()
