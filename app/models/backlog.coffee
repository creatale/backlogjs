Model = require 'models/base/model'
Collection = require 'models/base/collection'
{Sprints} = require './sprints'
{Stories} = require './stories'
{Terms} = require './terms'

module.exports.Backlog = class Backlog extends Model
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
		# Find user stories with non-unique priorities.
		conflicts = false
		duplicatesByPriority = []
		for story in @stories.models
			if (priority = story.get 'priority')?
				duplicatesByPriority[priority] ?= []
				duplicatesByPriority[priority].push story.id
		for priority, duplicates of duplicatesByPriority
			for duplicate in duplicates
				story = @stories.get duplicate
				duplicates = duplicates.filter (id) -> id isnt story?.id
			if duplicates.length > 0
				console.warn 'Priority conflicts', priority, duplicates
				conflicts = true
		if conflicts
			# Re-assign priorities with some spacing.
			for story, index in @stories.models
				story.set 'priority', (index + 1) * 5, {silent: true}

	toJSON: (options) =>
		object = {}
		object.name = @get 'name'
		object.terms = @terms.toJSON options
		object.sprints = @sprints.toJSON options
		object.stories = @stories.toJSON options
		return object
