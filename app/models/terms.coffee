class Term extends Backbone.Model
	term: 'Käse'
	description: 'Als Maus möchte ich ganz viel Käse im Kühlschrank haben, um immer satt und glücklich zu sein.'
	#TODO: bedeutung, abgrenzung, gültigkeit, bezeichnung, querverweise
	
module.exports = class Terms extends Backbone.Collection
	model: Term
