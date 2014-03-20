Model = require 'models/base/model'
Collection = require 'models/base/collection'

module.exports.Term = class Term extends Model
	defaults: ->
		term: ''
		description: ''
		scope: ''
		identification: ''
		references: []

	toJSON: (options) =>
		object = _.clone @attributes
		for key, value of object
			if value in [null, undefined, ''] or _.isNaN(value) or _.isEqual(value, {}) or (_.isArray(value) and value.length is 0)
				delete object[key]
		return object

module.exports.Terms = class Terms extends Collection
	model: Term
	comparator: 'term'
