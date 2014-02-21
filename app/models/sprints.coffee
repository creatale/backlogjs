class Sprint extends Backbone.Model
	initialize: ->
		@id = parseInt(@get('id'), 10)
		@start = moment(@get('start'))
		@end = moment(@get('end'))
		@points = 0

module.exports = class Sprints extends Backbone.Collection
	model: Sprint
