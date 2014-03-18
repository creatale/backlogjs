CollectionView = require 'views/base/collection-view'
View = require 'views/base/view'

class ListItemView extends View
	template: require 'views/term/templates/list-item'
	tagName: 'dt'

module.exports = class StoryListView extends CollectionView
	autoRender: true
	template: require 'views/term/templates/list'
	listSelector: 'dl'
	itemView: ListItemView
