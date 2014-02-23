Controller = require 'controllers/base/controller'
{Backlog} = require 'models/backlog'
HomeView = require 'views/home-view'
HeaderView = require 'views/header-view'

module.exports = class HomeController extends Controller
	index: ->
		@backlog = new Backlog BacklogDB, {parse: true}
		@reuse 'header', HeaderView, region: 'header', model: @backlog
		@view = new HomeView
			model: @backlog
			region: 'main'
