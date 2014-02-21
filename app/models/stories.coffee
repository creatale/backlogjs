class Story extends Backbone.Model
	defaults: ->
		name: ''
		description: ''
		acceptanceTerms: []
		notes: []
		scenario: []
		priority: undefined
		priorityDuplicates: []
		sprint: undefined
		points: undefined

	parse: (response, options) ->
		response.id = parseInt response.id, 10
		return response

module.exports = class Stories extends Backbone.Collection
	model: Story
	comparator: 'id'

	#comparator: (a, b) ->
	#	if a.priority > b.priority or not b.priority?
	#		return -1
	#	else if a.priority < b.priority or not a.priority?
	#		return 1
	#	else
	#		return 0

	#filterWithIds: (ids) ->
	#	_(@models.filter (c) -> _.contains ids, c.id)
