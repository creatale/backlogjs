View = require 'views/base/view'

# Site view is a top-level view which is bound to body.
module.exports = class HeaderView extends View
	className: 'navbar navbar-default'
	template: require './templates/header'
	events:
		'click #save': 'save'

	render: =>
		super
		document.title = @model.get('name') + ' - Backlog'

	save: (event) =>
		@publishEvent 'backlog:save'
