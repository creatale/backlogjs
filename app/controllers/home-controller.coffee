Controller = require 'controllers/base/controller'
{Backlog} = require 'models/backlog'
HeaderView = require 'views/header-view'
HomeView = require 'views/home-view'
StoryListView = require 'views/story/list-view'
StoryEditView = require 'views/story/edit-view'

module.exports = class HomeController extends Controller
	index: ->
		@backlog = new Backlog BacklogDB, {parse: true}
		@reuse 'header', HeaderView, region: 'header', model: @backlog
		@view = new HomeView
			model: @backlog
			region: 'main'
		@view.subview 'story-list', new StoryListView
			collection:  @backlog.stories
			region: 'stories'
		@subscribeEvent 'story:edit', (model) ->
			view = new StoryEditView
				model: model
			view.render()
