Promise = require('bluebird')
commandExists = require('command-exists')

###*
# @summary Check if a command exists in the path
# @function
# @protected
#
# @param {String} command - command
# @returns {Promise<Boolean>} whether the command exists
#
# @example
# utils.exists('ls').then (exists) ->
#		if exists
#			console.log('The command exists')
#		else
#			console.log('The command does not exist')
###
exports.exists = (command) ->
	Promise.fromNode (callback) ->
		commandExists(command, callback)
