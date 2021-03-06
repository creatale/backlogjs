Controller = require 'controllers/base/controller'
{Backlog} = require 'models/backlog'
{Story} = require 'models/stories'
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
		@subscribeEvent 'story:add', (story) =>
			maxId = 0
			for otherStory in @backlog.stories.models
				maxId = Math.max(otherStory.id, maxId)
			newStory = new Story
				id: maxId + 1
				priority: story.get('priority') + 1
			@backlog.stories.add newStory
		@subscribeEvent 'story:remove', (story) =>
			@backlog.stories.remove story
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
		@subscribeEvent 'backlog:search', (search) =>
			if search.substr(0, 1) is '/'
				re = new RegExp(search.replace(/^\//, '').replace(/\/$/, ''), 'i')
			else
				re = new RegExp(search.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&"), 'i')
			storyView = @view.subview 'story-list'
			storyView.filter (item, index) ->
				text = (item.get('name') + item.get('description'))
				return re.test text
		@subscribeEvent 'backlog:save', =>
			db = 'BacklogDB = ' + JSON.stringify(@backlog.toJSON(), undefined, 2)
			saveAs(new Blob([db], {type: "text/plain;charset=utf-8"}), 'backlog.js')
