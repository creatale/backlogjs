Sprints = require './sprints'
Stories = require './stories'
Terms = require './terms'

calculateSprintStoryPoints = (backlog) ->
	result = {}
	for story in backlog.stories.toJSON()
		sprint = story.sprint
		if sprint? and story.points?
			result[sprint] = 0  unless result[sprint]?
			result[sprint] += story.points  unless story.extra
	return result

countStoriesPerPriority = (backlog) ->
	storiesPerPriority = {}
	for story in backlog.stories.toJSON()
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

module.exports = class Backlog extends Backbone.Model
	initialize: ->
		@sprints = new Sprints(@get('sprints'), {})
		@sprints.bind 'change', @save
		@stories = new Stories(@get('stories'), {})
		@stories.bind 'change', @save
		@terms = new Stories(@get('terms'), {})
		@terms.bind 'change', @save

		#TODO: unhack this
		@sortedStories = @stories.toJSON().sort(byPriority)
		@sprintStoryPoints = calculateSprintStoryPoints @
		@storiesPerPriority = countStoriesPerPriority @
