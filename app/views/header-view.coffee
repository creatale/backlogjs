View = require 'views/base/view'

# Site view is a top-level view which is bound to body.
module.exports = class HeaderView extends View
	className: 'navbar navbar-default'
	template: require './templates/header'
	events:
		'click #save': 'save'

	save: (event) =>
		@publishEvent 'backlog:save'
