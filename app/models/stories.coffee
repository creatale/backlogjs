Model = require 'models/base/model'
Collection = require 'models/base/collection'

module.exports.Story = class Story extends Model
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

module.exports.Stories = class Stories extends Collection
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
