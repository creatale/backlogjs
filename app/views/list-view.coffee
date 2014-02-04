
generateRemarks = ->
	result = ""
	for id of remarks
		result += "<p><b id=\"remark\"" + id + "\">" + id + ":</b> " + remarks[id] + "</p>"
	result

generateGoToSprint = ->
	div = $("<div class=\"hidden-print\">Gehe zu Sprint: </div>")
	sortedStories = stories.sort(byPriority)
	lastSprint = -1
	i = 0

	while i < sortedStories.length
		div.append " <a href=\"#story" + sortedStories[i].id + "\" class=\"btn btn-default btn-sm\">" + sortedStories[i].sprint + "</a>"  if sortedStories[i].sprint? and sortedStories[i].sprint isnt lastSprint
		lastSprint = sortedStories[i].sprint
		i++
	div

 backlog = ->
 	element = $('<div>')
	element.append "<div id=\"sidebar\" class=\"pull-right hidden-print\"><div class=\"checkbox\"><input type=\"checkbox\" id=\"withoutSprint\" /> <label for=\"withoutSprint\">Ohne Sprint</label></div></div>"
	checkbox = element.find("#withoutSprint")
	checkbox.on "change", (event) ->
		table.empty()
		generateTable table,
			filterSprints: not checkbox.prop("checked")

		false

	table = $("<table class=\"table table-condensed\">" + "</table>")
	generateTable table,
		filterSprints: not checkbox.prop("checked")

	element.append "<h2>Backlog</h2>"
	element.append generateGoToSprint()
	element.append table
	element.append generateRemarks()
	dl = $("<dl></dl>")
	_i = undefined
	_len = undefined
	_i = 0
	_len = definitions.length

	while _i < _len
		definition = definitions[_i]
		dl.append "<dt id=\"definition" + _i + "\">" + definition.term + "</dt>"
		dl.append "<dd>" + explain(definition.explanation) + "</dd>"
		_i++
	element.append "<h2 id=\"glossar\">Glossar</h2>"
	element.append dl
	return element



generateTable = (table, options) ->
	sprintStoryPoints = calculateSprintStoryPoints()
	storiesPerPriority = countStoriesPerPriority()
	filterSprints = options.filterSprints or false
	tbody = $("<tbody></tbody>")
	thead = $("<thead>" + "  <tr>" + "    <th></th>" + "    <th>Name" + remark(2, "<span class=\"glyphicon glyphicon-question-sign\"></span> Zu dieser User Story sind Notizen hinterlegt.") + "</th>" + "    <th>Beschreibung</th>" + "    <th>Abnahme</th>" + "    <th>Demo</th>" + "    <th>Story Points" + remark(1, "Werte in Klammern sind eine unverbindliche Schätzung.") + "<sup>,</sup>" + remark(3, "Die Prozente geben den Anteil am Gesamtaufwand (Summe aller Story Points) für den Sprint an.") + "</th>" + "    <th>Priorität</th>" + "    <th>Sprint</th>" + "    <th class=\"hidden-print\">Notizen</th>" + "    <th>Abhängig&shy;keiten</th>" + "  </tr>" + "</thead>")
	table.append(thead).append tbody
	storiesFiltered = stories.filter((a) ->
		filterSprints or not a.sprint?
	).sort(byPriority)
	maxId = 0
	_i = undefined
	_len = undefined
	lastSprint = -1
	_i = 0
	_len = storiesFiltered.length

	while _i < _len
		story = storiesFiltered[_i]
		newSprint = false
		unless lastSprint is story.sprint
			newSprint = true  if lastSprint isnt -1
			lastSprint = story.sprint
		tr = $("<tr id=\"story" + story.id + "\"" + ((if newSprint then " class=\"newsprint\"" else "")) + "></tr>")
		maxId = Math.max(story.id, maxId)
		tr.append "<td>#" + story.id + "</td>"
		tr.append "<td>" + story.name + ((if story.notes? then " <span class=\"glyphicon glyphicon-question-sign\"></span>" else "")) + "</td>"
		tr.append "<td>" + explain(story.description) + "</td>"
		tr.append "<td>" + generateList(story.acceptanceTerms) + "</td>"
		tr.append "<td>" + generateList(story.demoProcedure, "ordered") + "</td>"
		tr.append "<td>" + ((if story.points? then story.points + ((if story.sprint? and not story.extra then "<br />(" + (story.points * 100 / sprintStoryPoints[story.sprint]).toFixed(1) + "%)" else "")) else ((if story.estPoints? then ("<span class=\"nonbinding\" title=\"unverb. Schätzung\">(" + story.estPoints + ")</span>") else "")))) + "</td>"
		tr.append "<td>" + ((if story.priority? then story.priority + ((if storiesPerPriority[story.priority].length > 1 then " <span class=\"text-danger\" title=\"Folgende User Stories haben die gleiche Priorität: #" + storiesPerPriority[story.priority].join(", #") + "\"><span class=\"glyphicon glyphicon-warning-sign\"></span></span>" else "")) else "")) + "</td>"
		tr.append "<td>" + ((if story.sprint? then ("<span class=\"badge\"" + ((if sprints[story.sprint]? then " title=\"" + sprints[story.sprint].start.format("DD.MM.YYYY") + " - " + sprints[story.sprint].end.format("DD.MM.YYYY") + "\"" else "")) + ">" + story.sprint + "</span>") else "")) + "</td>"
		tr.append "<td class=\"hidden-print\">" + generateList(story.notes) + "</td>"
		dependencies = ""
		if story.dependencies?
			_i2 = undefined
			_len2 = undefined
			_i2 = 0
			_len2 = story.dependencies.length

			while _i2 < _len2
				dependency = story.dependencies[_i2]
				dependencies += ", "  unless dependencies is ""
				dependencies += "<a href=\"#story" + dependency + "\">#" + dependency + "</a>"
				_i2++
		tr.append "<td>" + dependencies + "</td>"
		tbody.append tr
		_i++
	console.log "Next ID: #" + (maxId + 1)
	false

generateList = (values, style) ->
	listTag = "ul"
	listTag = "ol"  if style is "ordered"
	list = "<" + listTag + ">"
	if typeof values is "string"
		list += "<li>" + values + "</li>"
	else
		for index of values
			list += "<li>" + values[index] + "</li>"
	list += "</" + listTag + ">"
	list

explain = (string) ->
	return string
	_i = undefined
	_len = undefined
	
	# replace explained in two passes to avoid replacing terms in the title attribute of the explantion
	_i = 0
	_len = definitions.length

	while _i < _len
		definition = definitions[_i]
		string = string.replace(definition.term, "<a href=\"#definition" + _i + "\"><span class=\"text-info\" title=\"\">" + definition.term + "</span></a>")
		_i++
	_i = 0
	_len = definitions.length

	while _i < _len
		definition = definitions[_i]
		string = string.replace("<a href=\"#definition" + _i + "\"><span class=\"text-info\" title=\"\">" + definition.term + "</span></a>", "<a href=\"#definition" + _i + "\"><span class=\"text-info\" title=\"" + definition.explanation + "\">" + definition.term + "</span></a>")
		_i++
	string

	refRemark id

refRemark = (id) ->
	"<a href=\"#remark" + id + "\"><sup>" + id + "</sup></a>"
#console.log 'XXX', backlog


bySprint = (filterSprints) ->
	return (a) -> filterSprints or not a.sprint?

byPriority = (a, b) ->
	if a.priority > b.priority or not b.priority?
		return -1
	else if a.priority < b.priority or not a.priority?
		return 1
	else
		return 0

module.exports = class ListView
	template: require 'views/templates/list'
	id: 'list'
	
	constructor: (@model) ->
		@filterSprints = []

	render: =>
		@$el = $('<div>')
		@$el.attr('id', @id).html(@template(@model))
		@renderTable()

	renderTable: =>
		sprintStoryPoints = []#calculateSprintStoryPoints()
		storiesPerPriority = []#countStoriesPerPriority()
		
		###
		storiesFiltered = @model.stories.filter(bySprint(@filterSprints)).sort(byPriority)
		maxId = 0
		lastSprint = -1
		for story in @model.stories
			newSprint = false
			unless lastSprint is story.sprint
				newSprint = true  if lastSprint isnt -1
				lastSprint = story.sprint
			tr = $("<tr id=\"story" + story.id + "\"" + ((if newSprint then " class=\"newsprint\"" else "")) + "></tr>")
			maxId = Math.max(story.id, maxId)
			tr.append "<td>#" + story.id + "</td>"
			tr.append "<td>" + story.name + ((if story.notes? then " <span class=\"glyphicon glyphicon-question-sign\"></span>" else "")) + "</td>"
			tr.append "<td>" + explain(story.description) + "</td>"
			tr.append "<td>" + generateList(story.acceptanceTerms) + "</td>"
			tr.append "<td>" + generateList(story.demoProcedure, "ordered") + "</td>"
			tr.append "<td>" + ((if story.points? then story.points + ((if story.sprint? and not story.extra then "<br />(" + (story.points * 100 / sprintStoryPoints[story.sprint]).toFixed(1) + "%)" else "")) else ((if story.estPoints? then ("<span class=\"nonbinding\" title=\"unverb. Schätzung\">(" + story.estPoints + ")</span>") else "")))) + "</td>"
			tr.append "<td>" + ((if story.priority? then story.priority + ((if storiesPerPriority[story.priority].length > 1 then " <span class=\"text-danger\" title=\"Folgende User Stories haben die gleiche Priorität: #" + storiesPerPriority[story.priority].join(", #") + "\"><span class=\"glyphicon glyphicon-warning-sign\"></span></span>" else "")) else "")) + "</td>"
			tr.append "<td>" + ((if story.sprint? then ("<span class=\"badge\"" + ((if sprints[story.sprint]? then " title=\"" + sprints[story.sprint].start.format("DD.MM.YYYY") + " - " + sprints[story.sprint].end.format("DD.MM.YYYY") + "\"" else "")) + ">" + story.sprint + "</span>") else "")) + "</td>"
			tr.append "<td class=\"hidden-print\">" + generateList(story.notes) + "</td>"
			dependencies = ""
			for dependency in story.dependencies or []
				dependencies += ", "  unless dependencies is ""
				dependencies += "<a href=\"#story" + dependency + "\">#" + dependency + "</a>"
		 
			tr.append "<td>" + dependencies + "</td>"
			tbody.append tr

		console.log "Next ID: #" + (maxId + 1)
		###