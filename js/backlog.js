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
	for (_i = 0, _len = definitions.length; _i < _len; _i++) {
		var definition = definitions[_i];
		string = string.replace(definition.term, '<span class="text-info" title="' + definition.explanation + '">' + definition.term + '</span>');
	}
	return string;
}

var stories = [];

function story(content) {
  stories.push(content);
  return false;
}

function backlog(element) {
	var checkbox = element.append('<div class="pull-right hidden-print"><div class="checkbox"><label><input type="checkbox"> Ohne Sprint</label></div></div>').find('input');
	checkbox.on('change', function(event) {
		table.empty();
		generateTable(table, !checkbox.prop('checked'));
		return false;
	});

	var table = $('<table class="table table-condensed">' +
		'</table>');
	
	generateTable(table, !checkbox.prop('checked'));
	
	element.append('<h2>Backlog</h2>');
	element.append(table);

	var dl = $('<dl></dl>')

	var _i, _len;
	for (_i = 0, _len = definitions.length; _i < _len; _i++) {
		var definition = definitions[_i];
		dl.append('<dt>' + definition.term + '</dt>');
		dl.append('<dd>' + explain(definition.explanation) + '</dd>');
	}

	element.append('<h2>Glossar</h2>');
	element.append(dl);
	
	return false;
}

function generateTable(table, filterSprints) {
	var tbody = $('<tbody></tbody>')
	var thead = $('<thead>' +
		'  <tr>' +
		'    <th></th>' +
		'    <th>Name</th>' +
		'    <th>Beschreibung</th>' +
		'    <th>Abnahme</th>' +
		'    <th>Demo</th>' +
		'    <th>Story Points</th>' +
		'    <th>Priorität</th>' +
		'    <th>Sprint</th>' +
		'  </tr>' +
		'</thead>');	
	table.append(thead).append(tbody)
	
	storiesFiltered = stories.filter(function(a) {
		return filterSprints || a.sprint == null;
	}).sort(function(a, b) {
		if (a.priority > b.priority || b.priority == null) {
			return -1;
		} if (a.priority < b.priority || a.priority == null) {
			return 1;
		} else {
			return 0;
		}
	});
	
	var maxId = 0;
	var _i, _len;
	for (_i = 0, _len = storiesFiltered.length; _i < _len; _i++) {
		var story = storiesFiltered[_i];
		var tr = $('<tr></tr>');
		maxId = Math.max(story.id, maxId);
		tr.append('<td>#' + story.id + '</td>');
		tr.append('<td>' + story.name + '</td>');
		tr.append('<td>' + explain(story.description) + '</td>');
		terms = '<td><ul>'
		for (var term in story.acceptanceTerms) {
			terms += '<li>' + story.acceptanceTerms[term] + '</li>';
		}
		terms += '</ul></td>';
		tr.append(terms);
		steps = '<td><ol>'
		for (var step in story.demoProcedure) {
			steps += '<li>' + story.demoProcedure[step] + '</li>';
		}
		steps += '</ol></td>';
		tr.append(steps);
		tr.append('<td>' + (story.points || '') + '</td>');
		tr.append('<td>' + (story.priority != null ? story.priority : '') + '</td>');
		tr.append('<td>' 
			+ (story.sprint != null ? ('<span class="badge">' + story.sprint + '</span>') : '')
			+ (story.notes != null ? ' <span title="' + story.notes + '" class="glyphicon glyphicon-question-sign"></span>' : '') 
			+ '</td>');
		tbody.append(tr);
	}
	
	console.log('Next ID: #' + (maxId + 1));
	
	return false;
}

function errorHandler(message, file, line) {
	$('body').prepend('<div class="alert alert-danger"><b>Error!</b> ' + message + '</div>');
	return false;
}

window.onerror = errorHandler;
