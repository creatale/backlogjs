Model = require 'models/base/model'
Collection = require 'models/base/collection'

module.exports.Sprint = class Sprint extends Model
	defaults: ->
		points: 0
		start: new Date()
		end: new Date()

	parse: (response, options) ->
		response.id = parseInt response.id, 10
		response.start = moment response.start
		response.end = moment response.end
		return response
		
module.exports.Sprints = class Sprints extends Collection
	model: Sprint
	comparator: 'id'
