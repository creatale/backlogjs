View = require 'views/base/view'

module.exports = class HomeView extends View
	autoRender: true
	id: 'home'
	template: require 'views/templates/home'
	events:
		'click tr': 'show'

	show: (event) =>
		console.log 'NYI'
		@$('#story-modal').modal()
