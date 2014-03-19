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
				#TODO: throw an exception here or something like that
				duplicates = duplicates.filter (id) -> id isnt story.id
				if duplicates.length > 0
					throw new Error 'Duplicated priorities'
