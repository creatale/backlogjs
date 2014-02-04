module.exports =
	definitions: []
	stories: []
	sprints: {}
	remarks: []

definition = (term, explanation) ->
	module.exports.definitions.push
		term: term
		explanation: explanation

story = (content) ->
	module.exports.stories.push content

sprint = (content) ->
	content.start = moment(content.start, "DD.MM.YYYY")  if typeof content.start is "string"
	content.end = moment(content.end, "DD.MM.YYYY")  if typeof content.end is "string"
	module.exports.sprints[content.id] = content

remark = (id, content) ->
	module.exports.remarks[id] = content  if content?

story
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

story
	id: 2
	name: 'Mauseloch'
	description: 'Als Maus möchte ich ein Mauseloch in der Wand haben, um vor der Katze sicher zu sein.'
	acceptanceTerms: [
		'Am Boden bündiges Loch in der Wand'
		'Lochdurchmesser 10cm'
		'Lochtiefe 15cm'
	]
	demoProcedure: [
		'Maus ins Loch setzen'
		'Normhauskatze vor das Loch setzen'
		'Maus bleibt unversehrt'
	]
	priority: 995
	points: 13
	sprint: 1

story
	id: 3
	name: 'Dekoration'
	description: 'Als Maus möchte ich eine schöne Einrichtung für mein Mauseloch, damit ich mich wohl fühle.'
	acceptanceTerms: [
		'Ein Bett im Mauseloch'
		'Ein Schrank im Mauseloch'
		'Ein Tisch im Mauseloch'
	]
	demoProcedure: [
		'Rundgang durch das Mauseloch'
		'Bett zeigen'
		'Schrank zeigen'
		'Tisch zeigen'
	]
	dependencies: [
		2
	]
	priority: 900
	estPoints: 20

sprint
	id: 1
	start: '10.12.1815'
	end: '27.11.1852'
	
definition 'Maus', 'Eine Hausmaus (Mus musculus), die in von Menschen bewohnten Häusern lebt.'
definition 'Katze', 'Der Erzfeind aller Hausmäuse - je satter, desto ungefährlicher.'
