
bySprint = (filterSprints) ->
	return (a) -> filterSprints or not a.sprint?



module.exports = class ListView
	template: require 'views/templates/list'
	id: 'list'
	
	constructor: (@model) ->
		@filterSprints = false
	
	render: =>
		@$el = $('<div>')
		@$el.attr('id', @id).html(@template(@model))
		#
		checkbox = @$el.find("#withoutSprint")
		checkbox.on "change", (event) =>
			@filterSprints = not @filterSprints
			#TODO: update table.
		return false
