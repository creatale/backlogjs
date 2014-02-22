Controller = require 'controllers/base/controller'
{Backlog} = require 'models/backlog'
HomeView = require 'views/home-view'
HeaderView = require 'views/header-view'

module.exports = class HomeController extends Controller
	beforeAction: ->
		super
		@reuse 'header', HeaderView, region: 'header'

	index: ->
		@backlog = new Backlog BacklogDB, {parse: true}
		@view = new HomeView
			model: @backlog
			region: 'main'
