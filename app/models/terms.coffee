Model = require 'models/base/model'
Collection = require 'models/base/collection'

module.exports.Term = class Term extends Model
	defaults: ->
		term: ''
		description: ''
		scope: ''
		identification: ''
		references: []	

module.exports.Terms = class Terms extends Collection
	model: Term
	comparator: 'term'
