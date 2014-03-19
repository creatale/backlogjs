Model = require 'models/base/model'
Collection = require 'models/base/collection'

module.exports.Story = class Story extends Model
	defaults: ->
		name: ''
		description: ''
		requirements: []
		process: []
		notes: []
		priority: undefined
		sprint: undefined
		points: undefined
		pointsShare: undefined
		nonCommital: true
		#dependencies

	parse: (response, options) ->
		response.id = parseInt response.id, 10
		return response

module.exports.Stories = class Stories extends Collection
	model: Story
	comparator: 'id'

	constructor: ->
		super
		@on 'change:priority', => @sort()

	comparator: (a, b) ->
		if a.get('priority') > b.get('priority') or not b.get('priority')?
			return -1
		else if a.get('priority') < b.get('priority') or not a.get('priority')?
			return 1
		else
			return 0
