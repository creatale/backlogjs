Model = require 'models/base/model'
Collection = require 'models/base/collection'

parseArray = (value) ->
	if not value? or value is ''
		return []
	else if not _.isArray value
		return [value]
	else
		return value

module.exports.Story = class Story extends Model
	defaults: ->
		name: ''
		description: ''
		dependencies: undefined
		requirements: undefined
		process: undefined
		comments: undefined
		priority: undefined
		points: undefined
		pointsShare: undefined
		sprint: undefined
		nonCommital: false

	parse: (response, options) =>
		response.id = parseInt response.id, 10
		response.dependencies = parseArray response.dependencies
		response.requirements = parseArray response.requirements
		response.process = parseArray response.process
		response.comments = parseArray response.comments
		response.priority = 
		if not _.isNaN(value = parseInt(response.priority, 10))
			response.priority = value
		else
			response.priority = 0
		response.points = Number response.points
		response.pointsShare = Number response.pointsShare
		return response

	toJSON: (options) =>
		object = super options
		for key, value of object
			if value in [null, undefined, ''] or _.isNaN(value) or _.isEqual(value, {}) or (_.isArray(value) and value.length is 0)
				delete object[key]
		delete object['pointsShare']
		delete object['nonCommital'] unless object.nonCommital
		return object

module.exports.Stories = class Stories extends Collection
	model: Story
	comparator: 'id'

	constructor: ->
		super
		@on 'change:priority', => @sort()
		@sort()

	comparator: (a, b) ->
		if a.get('priority') > b.get('priority')
			return -1
		else if a.get('priority') < b.get('priority')
			return 1
		else
			return 0

	toJSON: (options) ->
		array = super options
		array.sort (a, b) -> a.id - b.id
		return array
