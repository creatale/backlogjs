CollectionView = require 'views/base/collection-view'
View = require 'views/base/view'

class ListItemView extends View
	template: require 'views/term/templates/list-item'
	tagName: 'tr'

module.exports = class TermListView extends CollectionView
	autoRender: true
	template: require 'views/term/templates/list'
	listSelector: 'tbody'
	itemView: ListItemView
