View = require 'views/base/view'

module.exports = class ModalView extends View
	className: 'modal fade'
	container: 'body'
	events:
		'click .save': 'save'
		'click .close,.close': 'hide'

	hide: (event) =>
		event.preventDefault() if event?
		@$el.modal 'hide'
		return false

	render: =>
		super
		@$el.modal 'show'
		@$el.on 'hidden.bs.modal', (event) =>
			@remove()
		return @
