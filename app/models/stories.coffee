class Story extends Backbone.Model
	id: 1
	name: 'Käse'
	description: 'Als Maus möchte ich ganz viel Käse im Kühlschrank haben, um immer satt und glücklich zu sein.'
	acceptanceTerms: [
		'1kg Käse im Kühlschrank'
	]
	demoProcedure: [
		'Kühlschrank aufmachen'
		'Käse rausnehmen und wiegen'
		'Käse zurücklegen und Kühlschrank schließen'
	]
	priority: 999
	points: 42
	sprint: 1
	notes: [
		'Welche Sorte Käse?'
	]

module.exports = class Stories extends Backbone.Collection
	model: Story
	filterWithIds: (ids) ->
		_(@models.filter (c) -> _.contains ids, c.id)
