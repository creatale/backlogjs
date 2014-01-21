var definitions = [];

function definition(term, explanation) {
	definitions.push({
		'term': term,
		'explanation': explanation
	});
	return false;
}

function explain(string) {
	var _i, _len;
	// replace explained in two passes to avoid replacing terms in the title attribute of the explantion
	for (_i = 0, _len = definitions.length; _i < _len; _i++) {
		var definition = definitions[_i];
		string = string.replace(definition.term, '<a href="#definition' + _i + '"><span class="text-info" title="">' + definition.term + '</span></a>');
	}
	for (_i = 0, _len = definitions.length; _i < _len; _i++) {
		var definition = definitions[_i];
		string = string.replace('<a href="#definition' + _i + '"><span class="text-info" title="">' + definition.term + '</span></a>', '<a href="#definition' + _i + '"><span class="text-info" title="' + definition.explanation + '">' + definition.term + '</span></a>');
	}
	return string;
}

var stories = [];

function story(content) {
	stories.push(content);
	return false;
}

var sprints = {};

function sprint(content) {
	if (typeof content.start === 'string') {
		content.start = moment(content.start, 'DD.MM.YYYY');
	}
	if (typeof content.end === 'string') {
		content.end = moment(content.end, 'DD.MM.YYYY');
	}
	sprints[content.id] = content;
	return false;
}

var remarks = [];

function remark(id, content) {
	if (content != null) {
		remarks[id] = content;
	}
	return refRemark(id);
}

function refRemark(id) {
	return '<a href="#remark' + id + '"><sup>' + id + '</sup></a>';
}

function generateRemarks() {
	var result = '';
	for (id in remarks) {
		result += '<p><b id="remark"' + id + '">' + id + ':</b> ' + remarks[id] + '</p>'
	}
	return result
}

function generateGoToSprint() {
	var div = $('<div class="hidden-print">Gehe zu Sprint: </div>');
	var sortedStories = stories.sort(byPriority);
	var lastSprint = -1;
		
	for (var i = 0; i < sortedStories.length; i++) {
		if (sortedStories[i].sprint != null && sortedStories[i].sprint != lastSprint) {
			div.append(' <a href="#story' + sortedStories[i].id +'" class="btn btn-default btn-sm">' + sortedStories[i].sprint + '</a>');
		}
		lastSprint = sortedStories[i].sprint;
	}
	return div;
}

function backlog(element) {
	element.append('<div id="sidebar" class="pull-right hidden-print"><div class="checkbox"><input type="checkbox" id="withoutSprint" /> <label for="withoutSprint">Ohne Sprint</label></div></div>');
	var checkbox = element.find('#withoutSprint');
	checkbox.on('change', function(event) {
		table.empty();
		generateTable(table, {
			filterSprints: !checkbox.prop('checked')
		});
		return false;
	});

	var table = $('<table class="table table-condensed">' +
		'</table>');
	
	generateTable(table, {
		filterSprints: !checkbox.prop('checked')
	});
	
	element.append('<h2>Backlog</h2>');
	element.append(generateGoToSprint());
	element.append(table);
	element.append(generateRemarks());

	var dl = $('<dl></dl>')

	var _i, _len;
	for (_i = 0, _len = definitions.length; _i < _len; _i++) {
		var definition = definitions[_i];
		dl.append('<dt id="definition' + _i + '">' + definition.term + '</dt>');
		dl.append('<dd>' + explain(definition.explanation) + '</dd>');
	}

	element.append('<h2 id="glossar">Glossar</h2>');
	element.append(dl);
	
	return false;
}

function byPriority(a, b) {
	if (a.priority > b.priority || b.priority == null) {
		return -1;
	} if (a.priority < b.priority || a.priority == null) {
		return 1;
	} else {
		return 0;
	}
}

function generateTable(table, options) {
	var sprintStoryPoints = calculateSprintStoryPoints();
	var storiesPerPriority = countStoriesPerPriority();
	var filterSprints = options.filterSprints || false;
	var tbody = $('<tbody></tbody>');
	var thead = $('<thead>' +
		'  <tr>' +
		'    <th></th>' +
		'    <th>Name' + remark(2, '<span class="glyphicon glyphicon-question-sign"></span> Zu dieser User Story sind Notizen hinterlegt.') + '</th>' +
		'    <th>Beschreibung</th>' +
		'    <th>Abnahme</th>' +
		'    <th>Demo</th>' +
		'    <th>Story Points' +
			remark(1, 'Werte in Klammern sind eine unverbindliche Schätzung.') +
			'<sup>,</sup>' +
			remark(3, 'Die Prozente geben den Anteil am Gesamtaufwand (Summe aller Story Points) für den Sprint an.') +
			'</th>' +
		'    <th>Priorität</th>' +
		'    <th>Sprint</th>' +
		'    <th class="hidden-print">Notizen</th>' +
		'    <th>Abhängig&shy;keiten</th>' +
		'  </tr>' +
		'</thead>');	
	table.append(thead).append(tbody);
	
	storiesFiltered = stories.filter(function(a) {
		return filterSprints || a.sprint == null;
	}).sort(byPriority);
	
	var maxId = 0;
	var _i, _len;
	var lastSprint = -1;
	for (_i = 0, _len = storiesFiltered.length; _i < _len; _i++) {
		var story = storiesFiltered[_i];
		var newSprint = false;
		if (lastSprint != story.sprint) {
			if (lastSprint !== -1) {
				newSprint = true;
			}
			lastSprint = story.sprint;
		}
		var tr = $('<tr id="story' + story.id + '"' + (newSprint ? ' class="newsprint"' : '') + '></tr>');
		maxId = Math.max(story.id, maxId);
		tr.append('<td>#' + story.id + '</td>');
		tr.append('<td>' + 
			story.name + 
			(story.notes != null ? ' <span class="glyphicon glyphicon-question-sign"></span>' : '') +
			'</td>');
		tr.append('<td>' + explain(story.description) + '</td>');
		tr.append('<td>' + 
			generateList(story.acceptanceTerms) + 
			'</td>');
		tr.append('<td>' + generateList(story.demoProcedure, 'ordered') + '</td>');
		tr.append('<td>' +
			(story.points != null 
				? story.points + (story.sprint != null ? '<br />(' + (story.points * 100 / sprintStoryPoints[story.sprint]).toFixed(1) + '%)' : '') 
				: (story.estPoints != null ? ('<span class="nonbinding" title="unverb. Schätzung">(' + story.estPoints + ')</span>') : '')) + 
			'</td>');
		tr.append('<td>' + (story.priority != null ? story.priority + (storiesPerPriority[story.priority].length > 1 ? ' <span class="text-danger" title="Folgende User Stories haben die gleiche Priorität: #' + storiesPerPriority[story.priority].join(', #') + '"><span class="glyphicon glyphicon-warning-sign"></span></span>' : '') : '') + '</td>');
		tr.append('<td>' +
			(story.sprint != null ? ('<span class="badge"' + 
				(sprints[story.sprint] != null ? ' title="' + sprints[story.sprint].start.format('DD.MM.YYYY') + ' - ' + sprints[story.sprint].end.format('DD.MM.YYYY') + '"' : '') + 
				'>' + story.sprint + '</span>') : '') +
			'</td>');
		tr.append('<td class="hidden-print">' + generateList(story.notes) + '</td>');
		var dependencies = '';
		if (story.dependencies != null) {
			var _i2, _len2;
			for (_i2 = 0, _len2 = story.dependencies.length; _i2 < _len2; _i2++) {
				var dependency = story.dependencies[_i2];
				if (dependencies != '') {
					dependencies += ', ';
				}
				dependencies += '<a href="#story' + dependency + '">#' + dependency + '</a>';
			}
		}
		tr.append('<td>' + dependencies + '</td>');
		tbody.append(tr);
	}
	
	console.log('Next ID: #' + (maxId + 1));
	
	return false;
}

function calculateSprintStoryPoints() {
	var result = {};
	for (i = 0; i < stories.length; i++) {
		var story = stories[i];
		var sprint = story.sprint;
		if (sprint != null && story.points != null) {
			if (result[sprint] == null) {
				result[sprint] = 0;
			}
			if (!story.extra) {
				result[sprint] += story.points;
		}
	}
	return result;
}

function countStoriesPerPriority() {
	var storiesPerPriority = {};
	for (i = 0; i < stories.length; i++) {
		var story = stories[i];
		if(story.priority != null) {
			if(storiesPerPriority[story.priority] == null) {
				storiesPerPriority[story.priority] = [];
			}
			storiesPerPriority[story.priority].push(story.id);
		}
	}
	return storiesPerPriority;
}

function generateList(values, style) {
	var listTag = 'ul';
	if (style === 'ordered') {
		listTag = 'ol'
	}
	var list = '<' + listTag + '>';
	if (typeof values === 'string') {
		list += '<li>' + values + '</li>';
	} else {
		for (var index in values) {
			list += '<li>' + values[index] + '</li>';
		}
	}
	list += '</' + listTag + '>';
	return list
}

function errorHandler(message, file, line) {
	$('body').prepend('<div class="alert alert-danger"><b>Error!</b> ' + message + '</div>');
	return false;
}

window.onerror = errorHandler;
