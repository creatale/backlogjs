
bySprint = (filterSprints) ->
	return (a) -> filterSprints or not a.sprint?


module.exports = class ListView extends Backbone.View
	template: require 'views/templates/list'
	id: 'list'
	
	constructor: (@model) ->
		@filterSprints = false
		@fileSaved = true
	
	render: =>
		@$el = $('<div>')
		@$el.attr('id', @id).html(@template(@model))
		# XXX
		checkbox = @$el.find("#withoutSprint")
		checkbox.on "change", (event) =>
			#TODO: remove hack
			@fileSaved = false
			#TODO: update table.
			console.warn 'NYI: filter stories with a sprint assigned'
			@filterSprints = not @filterSprints
		# XXX
		saveButton = @$el.find('#save')
		saveButton.on "click", (event) =>
			console.warn 'NYI: real saving'
			blob = new Blob(["console.log('NYI: backlog asset');"], {type: "text/plain;charset=utf-8"})
			saveAs(blob, 'backlog.js')
			@fileSaved = true
		window.onbeforeunload = (event) =>
			if @fileSaved
				return null
			else
				return 'You really should save your work.'
		return false
