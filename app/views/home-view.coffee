View = require 'views/base/view'

module.exports = class HomeView extends View
	autoRender: true
	id: 'home'
	regions:
		'stories': '#stories'
		'terms': '#terms'
	template: require 'views/templates/home'
