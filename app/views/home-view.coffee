View = require 'views/base/view'

module.exports = class HomeView extends View
	autoRender: true
	id: 'home'
	template: require 'views/templates/home'
	regions:
		'stories': '#stories'
