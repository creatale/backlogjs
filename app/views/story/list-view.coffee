CollectionView = require 'views/base/collection-view'
View = require 'views/base/view'

class ListItemView extends View
	template: require 'views/story/templates/list-item'
	tagName: 'tr'
	listen:
		'change model': 'render'
	events:
		'click': 'click'
		'focus': 'focus'
		'keydown': 'keypress'
		'click .edit': 'editStory'
		'click .add': 'addStory'
		'click .remove': 'removeStory'

	render: =>
		super
		@$el.attr 'tabindex', 0

	focus: (event) =>
		@publishEvent 'story:select', @model, false

	click: (event) =>
		@publishEvent 'story:select', @model, true

	keypress: (event) =>
		if event.which is 38 and event.shiftKey 
			# Up
			@publishEvent 'story:swap', @model, -1
		else if event.which is 40 and event.shiftKey 
			# Down
			@publishEvent 'story:swap', @model, +1
		else if event.which is 13
			# Return
			@publishEvent 'story:edit', @model

	editStory: (event) =>
		@publishEvent 'story:edit', @model

	addStory: (event) =>
		@publishEvent 'story:add', @model

	removeStory: (event) =>
		@publishEvent 'story:remove', @model

module.exports = class StoryListView extends CollectionView
	autoRender: true
	template: require 'views/story/templates/list'
	listSelector: 'tbody'
	id: 'story-list'
	itemView: ListItemView
	listen:
		'story:select mediator': 'select'

	initialize: =>
		super
		@selectedItem = null

	select: (model, refocus) =>
		@selectedItem.removeClass 'active' if @selectedItem?
		if model?
			@selectedItem = @getItemViews()[model.cid].$el
			@selectedItem.addClass 'active'
			@selectedItem.focus() if refocus
		else
			@selectedItem = null
		
###
mixin explain(string)
	//- Replace in two passes to avoid replacing terms in the title attribute of the explanation
	for definition, index in terms
		- string = string.replace(definition.term, '<a href="#definition' + index + '"><span class="text-info" title="">' + definition.term + '</span></a>');
	for definition, index in terms
		- string = string.replace('<a href="#definition' + index + '"><span class="text-info" title="">' + definition.term + '</span></a>', '<a href="#definition' + index + '"><span class="text-info" title="' + definition.explanation + '">' + definition.term + '</span></a>');
	!= string
###
