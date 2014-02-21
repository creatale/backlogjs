class Sprint extends Backbone.Model
	defaults: ->
		points: 0

	parse: (response, options) ->
		response.id = parseInt response.id, 10
		response.start = moment response.start
		response.end = moment response.end
		return response
		
module.exports = class Sprints extends Backbone.Collection
	model: Sprint
	comparator: 'id'
