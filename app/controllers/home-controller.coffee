Controller = require 'controllers/base/controller'
{Backlog} = require 'models/backlog'
HeaderView = require 'views/header-view'
HomeView = require 'views/home-view'
StoryListView = require 'views/story/list-view'
StoryEditView = require 'views/story/edit-view'
TermListView = require 'views/term/list-view'

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
		@view.subview 'term-list', new TermListView
			collection:  @backlog.terms
			region: 'terms'
		@subscribeEvent 'story:edit', (model) ->
			view = new StoryEditView
				model: model
			view.render()
		@subscribeEvent 'backlog:save', ->
			db = 'BacklogDB = ' + JSON.stringify(@model.toJSON(), undefined, 2)
			saveAs(new Blob([db], {type: "text/plain;charset=utf-8"}), 'backlog.js')
