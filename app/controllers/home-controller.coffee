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
		@subscribeEvent 'story:edit', (story) =>
			view = new StoryEditView
				model: @backlog
				story: story
			view.render()
		@subscribeEvent 'story:swap', (story, offset) => 
			stories = @backlog.stories
			otherStory = stories.at(Math.max(0, Math.min(stories.indexOf(story) + offset, stories.size() - 1)))
			a = story.get 'priority'
			b = otherStory.get 'priority'
			story.set 'priority', b
			otherStory.set 'priority', a
			@publishEvent 'story:select', story, true
		@subscribeEvent 'backlog:save', =>
			db = 'BacklogDB = ' + JSON.stringify(@backlog.toJSON(), undefined, 2)
			saveAs(new Blob([db], {type: "text/plain;charset=utf-8"}), 'backlog.js')
