CollectionView = require 'views/base/collection-view'
View = require 'views/base/view'

class ListItemView extends View
	template: require 'views/story/templates/list-item'
	tagName: 'tr'
	events:
		'click': 'edit'
	listen:
		'change model': 'render'

	edit: (event) =>
		@publishEvent 'story:edit', @model

module.exports = class StoryListView extends CollectionView
	autoRender: true
	template: require 'views/story/templates/list'
	listSelector: 'tbody'
	itemView: ListItemView
