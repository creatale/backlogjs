ModalView = require 'views/base/modal-view'

module.exports = class EditView extends ModalView
	template: require 'views/story/templates/edit'

	render: =>
		super
		# Display edit dialog.
		@$('#us-id').text(@model.get('id'))
		for attribute in ['name', 'description', 'points', 'sprint']
			@$('#us-' + attribute).val(@model.get(attribute))
		for attribute in ['acceptanceTerms', 'scenario', 'notes']
			@$('#us-' + attribute).val(@model.get(attribute).join("\n"))
		@$('#us-dependencies' + attribute).val(@model.get(attribute).join(', '))
		@$('#us-non-commital').attr('checked', @model.get('non-commital'))
		return @

	save: (event) =>
		id = @$('#us-id').text()
		for attribute in ['name', 'points', 'sprint']
			@model.set(attribute, @$('#us-' + attribute).val())
		for attribute in ['acceptanceTerms', 'scenario', 'notes']
			@model.set(attribute, @$('#us-' + attribute).val().split("\n").map((item) -> item.trim()))
		@model.set('dependencies', @$('#us-dependencies').val().split(',').map((item) -> item.trim()))
		@model.set('non-commital', @$('#us-non-commital').attr('checked'))
		@hide()
