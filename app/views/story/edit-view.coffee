ModalView = require 'views/base/modal-view'

parseValue = (string) -> 
	if string isnt ''
		return string.trim()
	else
		return undefined

parseArray = (value, seperator) ->
	array = value.split seperator
	array = array.map (item) -> item.trim()
	array = array.filter (item) -> item isnt ''
	return array

module.exports = class EditView extends ModalView
	template: require 'views/story/templates/edit'

	initialize: (options) =>
		super
		@story = @model.stories.get options.id

	render: =>
		super
		# Display edit dialog.
		@$('#us-id').text(@story.get('id'))
		for attribute in ['name', 'description', 'points', 'sprint']
			@$('#us-' + attribute).val(@story.get(attribute))
		for attribute in ['requirements', 'process', 'comments']
			@$('#us-' + attribute).val(@story.get(attribute).join("\n"))
		@$('#us-dependencies' + attribute).val(@story.get(attribute).join(', '))
		@$('#us-non-commital').attr('checked', @story.get('nonCommital'))
		return @

	save: (event) =>
		id = @$('#us-id').text()
		for attribute in ['name', 'points', 'sprint']
			@story.set(attribute, parseValue(@$('#us-' + attribute).val()))
		for attribute in ['requirements', 'process', 'comments']
			@story.set(attribute, parseArray(@$('#us-' + attribute).val(), "\n"))
		@story.set('dependencies', parseArray(@$('#us-dependencies').val(), ','))
		@story.set('nonCommital', @$('#us-non-commital').is(':checked'))
		@hide()
