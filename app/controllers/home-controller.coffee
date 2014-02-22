{Backlog} = require 'models/backlog'
ListView = require 'views/list-view'
Controller = require 'controllers/base/controller'

module.exports = class HomeController extends Controller
	index: ->
		@backlog = new Backlog BacklogDB, {parse: true}
		view = new ListView @backlog
		view.render()
		$('body').empty().append view.$el
