Controller = require 'controllers/base/controller'
{Backlog} = require 'models/backlog'
HomeView = require 'views/home-view'

module.exports = class HomeController extends Controller
	index: ->
		@backlog = new Backlog BacklogDB, {parse: true}
		view = new HomeView @backlog
		view.render()
		$('body').empty().append view.$el
