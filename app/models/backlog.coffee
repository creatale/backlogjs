Sprints = require './sprints'
Stories = require './stories'
Terms = require './terms'

module.exports = class Backlog extends Backbone.Model
	initialize: (attributes, options) ->
		# Nesting.
		@sprints = new Sprints(@get('sprints'), options)
		@stories = new Stories(@get('stories'), options)
		@terms = new Terms(@get('terms'), options)
		# Derived attributes.
		@updateStoryPoints()
		@updatePriorities()
		@on 'change', ->
			@updateStoryPoints()
			@updatePriorities()

	updateStoryPoints: =>
		# Update sums for each user story.
		for sprint in @sprints.models
			sprint.set 'points', 0
		for story in @stories.models
			sprint = @sprints.get(story.get('sprint'))
			sprint?.set('points', sprint.get('points') + story.get('points'))
			
	updatePriorities: =>
		# Mark user stories with non-unique priorities.
		for story in @stories.models
			story.duplicates = []
		duplicatesByPriority = []
		for story in @stories.models when story.priority?
			duplicatesByPriority[story.priority] ?= []
			duplicatesByPriority[story.priority].push story.id
		for priority, duplicates of duplicatesByPriority
			for duplicate in duplicates
				story = @stories.get duplicate
				story?.priorityDuplicates = duplicates.filter (id) -> id isnt story.id
