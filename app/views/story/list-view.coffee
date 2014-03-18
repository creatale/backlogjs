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
	id: 'story-list'
	itemView: ListItemView

###
mixin explain(string)
	//- Replace in two passes to avoid replacing terms in the title attribute of the explanation
	for definition, index in terms
		- string = string.replace(definition.term, '<a href="#definition' + index + '"><span class="text-info" title="">' + definition.term + '</span></a>');
	for definition, index in terms
		- string = string.replace('<a href="#definition' + index + '"><span class="text-info" title="">' + definition.term + '</span></a>', '<a href="#definition' + index + '"><span class="text-info" title="' + definition.explanation + '">' + definition.term + '</span></a>');
	!= string
###
