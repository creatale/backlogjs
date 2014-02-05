#
# Application entry point.
#
ListView = require 'views/list-view'
Backlog = require 'models/backlog'

calculateSprintStoryPoints = ->
	result = {}
	for story in Backlog.stories
		sprint = story.sprint
		if sprint? and story.points?
			result[sprint] = 0  unless result[sprint]?
			result[sprint] += story.points  unless story.extra
	return result

countStoriesPerPriority = ->
	storiesPerPriority = {}
	for story in Backlog.stories
		if story.priority?
			storiesPerPriority[story.priority] = []  unless storiesPerPriority[story.priority]?
			storiesPerPriority[story.priority].push story.id
	return storiesPerPriority

byPriority = (a, b) ->
	if a.priority > b.priority or not b.priority?
		return -1
	else if a.priority < b.priority or not a.priority?
		return 1
	else
		return 0

Backlog.sortedStories = Backlog.stories.sort(byPriority)
Backlog.sprintStoryPoints = calculateSprintStoryPoints()
Backlog.storiesPerPriority = countStoriesPerPriority()
#filterSprints = options.filterSprints or false
#storiesFiltered = stories.filter(bySprint(filterSprints)).sort(byPriority)

class Application
	constructor: ->
		window.onerror = @error
		@list()

	error: (message, file, line) ->
		$("body").prepend "<div class=\"alert alert-danger\"><b>Error!</b> " + message + "</div>"
		
	list: =>
		view = new ListView Backlog
		view.render()
		$('body').empty().append view.$el
		
$ -> new Application()
