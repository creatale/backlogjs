#
# Brunch configuration file. For documentation see:
# 	https://github.com/brunch/brunch/blob/stable/docs/config.md
#
exports.config =
	paths:
		watched: [
			'app'
		]
	files:
		javascripts:
			joinTo:
				'js/app.js': /^app(\/|\\)(?!vendor)/
				'js/vendor.js': /vendor(\/|\\)/
			order:
				before: [
					'app/vendor/js/jquery.js'
					'app/vendor/js/underscore.js'
					'app/vendor/js/backbone.js'
				]
		stylesheets:
			joinTo:
				'css/app.css': /^(app|vendor)/
			order:
				before: [
					'app/vendor/css/bootstrap.css'
				]
		templates:
			joinTo: 'js/app.js'
	plugins:
		static_jade:
			extension: ".static.jade"
	overrides:
		production:
			optimize: true
			sourceMaps: false
			plugins:
				autoReload:
					enabled: false
				cleancss:
					keepSpecialComments: 0
