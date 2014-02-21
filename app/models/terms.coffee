class Term extends Backbone.Model
	defaults: ->
		term: ''
		description: ''
		scope: ''
		identification: ''
		references: []	

module.exports = class Terms extends Backbone.Collection
	model: Term
	comparator: 'term'
